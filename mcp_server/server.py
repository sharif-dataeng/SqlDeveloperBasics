"""
SQL Developer Basics - Local MCP Server
Provides SQL helper tools: run queries, list tables, describe schemas, and browse SQL reference files.
"""

import os
import glob
import json
from mcp.server.fastmcp import FastMCP

# ---------------------------------------------------------------------------
# Initialise the MCP server (stdio transport)
# ---------------------------------------------------------------------------
mcp = FastMCP(
    "sql-helper",
    instructions=(
        "A local SQL helper MCP server for the SqlDeveloperBasics workspace. "
        "It can execute queries against a SQL Server instance, list databases/tables, "
        "describe table schemas, and browse the reference SQL scripts in the workspace."
    ),
)

# ---------------------------------------------------------------------------
# Workspace root (resolved once)
# ---------------------------------------------------------------------------
WORKSPACE_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

# ---------------------------------------------------------------------------
# Lazy pyodbc connection
# ---------------------------------------------------------------------------
_connection = None


def _get_connection(
    server: str = "(local)",
    database: str = "master",
    trusted: bool = True,
    connection_string: str | None = None,
):
    """Return (and cache) a pyodbc connection."""
    global _connection
    if _connection is not None:
        try:
            _connection.cursor().execute("SELECT 1")
            return _connection
        except Exception:
            _connection = None

    import pyodbc

    if connection_string:
        _connection = pyodbc.connect(connection_string, autocommit=True)
    else:
        driver = _find_odbc_driver()
        conn_str = (
            f"DRIVER={{{driver}}};"
            f"SERVER={server};"
            f"DATABASE={database};"
        )
        if trusted:
            conn_str += "Trusted_Connection=yes;"
        _connection = pyodbc.connect(conn_str, autocommit=True)
    return _connection


def _find_odbc_driver() -> str:
    """Pick the best installed ODBC driver for SQL Server."""
    import pyodbc

    preferred = [
        "ODBC Driver 18 for SQL Server",
        "ODBC Driver 17 for SQL Server",
        "ODBC Driver 13 for SQL Server",
        "SQL Server Native Client 11.0",
        "SQL Server",
    ]
    available = pyodbc.drivers()
    for drv in preferred:
        if drv in available:
            return drv
    raise RuntimeError(
        f"No SQL Server ODBC driver found. Available drivers: {available}"
    )


# ===========================  TOOLS  =======================================


@mcp.tool()
def run_query(
    sql: str,
    server: str = "(local)",
    database: str = "master",
    max_rows: int = 50,
    connection_string: str | None = None,
) -> str:
    """Execute a SQL query and return results as a JSON array of objects.

    Args:
        sql: The SQL statement to execute.
        server: SQL Server instance name (default: local).
        database: Database name to connect to.
        max_rows: Maximum number of rows to return (default 50, max 500).
        connection_string: Optional full ODBC connection string (overrides server/database).
    """
    max_rows = min(max_rows, 500)
    conn = _get_connection(server=server, database=database, connection_string=connection_string)
    cursor = conn.cursor()
    cursor.execute(sql)

    if cursor.description is None:
        return json.dumps({"status": "ok", "rows_affected": cursor.rowcount})

    columns = [col[0] for col in cursor.description]
    rows = cursor.fetchmany(max_rows)
    result = [dict(zip(columns, [str(v) if v is not None else None for v in row])) for row in rows]
    total = len(result)
    has_more = cursor.fetchone() is not None

    return json.dumps(
        {"columns": columns, "rows": result, "returned": total, "has_more": has_more},
        indent=2,
        default=str,
    )


@mcp.tool()
def list_databases(
    server: str = "(local)",
    connection_string: str | None = None,
) -> str:
    """List all databases on the SQL Server instance.

    Args:
        server: SQL Server instance name.
        connection_string: Optional full ODBC connection string.
    """
    conn = _get_connection(server=server, connection_string=connection_string)
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sys.databases ORDER BY name")
    dbs = [row[0] for row in cursor.fetchall()]
    return json.dumps(dbs, indent=2)


@mcp.tool()
def list_tables(
    server: str = "(local)",
    database: str = "master",
    schema: str | None = None,
    connection_string: str | None = None,
) -> str:
    """List all user tables in a database alternately filtered by schema.

    Args:
        server: SQL Server instance name.
        database: Database name.
        schema: Optional schema filter (e.g. 'dbo').
        connection_string: Optional full ODBC connection string.
    """
    conn = _get_connection(server=server, database=database, connection_string=connection_string)
    cursor = conn.cursor()
    query = (
        "SELECT TABLE_SCHEMA, TABLE_NAME "
        "FROM INFORMATION_SCHEMA.TABLES "
        "WHERE TABLE_TYPE = 'BASE TABLE'"
    )
    if schema:
        query += f" AND TABLE_SCHEMA = '{schema}'"
    query += " ORDER BY TABLE_SCHEMA, TABLE_NAME"
    cursor.execute(query)
    tables = [{"schema": row[0], "table": row[1]} for row in cursor.fetchall()]
    return json.dumps(tables, indent=2)


@mcp.tool()
def describe_table(
    table: str,
    server: str = "(local)",
    database: str = "master",
    schema: str = "dbo",
    connection_string: str | None = None,
) -> str:
    """Describe the columns of a table including data types, nullability, and key info.

    Args:
        table: Table name.
        server: SQL Server instance name.
        database: Database name.
        schema: Schema name (default 'dbo').
        connection_string: Optional full ODBC connection string.
    """
    conn = _get_connection(server=server, database=database, connection_string=connection_string)
    cursor = conn.cursor()
    cursor.execute(
        """
        SELECT
            c.COLUMN_NAME,
            c.DATA_TYPE,
            c.CHARACTER_MAXIMUM_LENGTH,
            c.IS_NULLABLE,
            CASE WHEN pk.COLUMN_NAME IS NOT NULL THEN 'YES' ELSE 'NO' END AS IS_PRIMARY_KEY
        FROM INFORMATION_SCHEMA.COLUMNS c
        LEFT JOIN (
            SELECT ku.COLUMN_NAME
            FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
            JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE ku
              ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
            WHERE tc.TABLE_SCHEMA = ? AND tc.TABLE_NAME = ? AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
        ) pk ON c.COLUMN_NAME = pk.COLUMN_NAME
        WHERE c.TABLE_SCHEMA = ? AND c.TABLE_NAME = ?
        ORDER BY c.ORDINAL_POSITION
        """,
        (schema, table, schema, table),
    )
    columns = [
        {
            "column": row[0],
            "data_type": row[1],
            "max_length": row[2],
            "nullable": row[3],
            "primary_key": row[4],
        }
        for row in cursor.fetchall()
    ]
    return json.dumps(columns, indent=2)


@mcp.tool()
def list_reference_sql_files(folder: str | None = None) -> str:
    """List SQL reference files available in the workspace.

    Args:
        folder: Optional subfolder under Reference/ to list (e.g. 'sql-basics', 'sql_scenario_casestudy').
                 If omitted, lists all SQL files under Reference/.
    """
    base = os.path.join(WORKSPACE_ROOT, "Reference")
    if folder:
        base = os.path.join(base, folder)
    pattern = os.path.join(base, "**", "*.sql")
    files = sorted(glob.glob(pattern, recursive=True))
    relative = [os.path.relpath(f, WORKSPACE_ROOT).replace("\\", "/") for f in files]
    return json.dumps(relative, indent=2)


@mcp.tool()
def read_sql_file(path: str) -> str:
    """Read the contents of a SQL file from the workspace.

    Args:
        path: Relative path from the workspace root (e.g. 'Reference/sql-basics/007.Select.sql').
    """
    full = os.path.normpath(os.path.join(WORKSPACE_ROOT, path))
    # Security: ensure the file is within the workspace
    if not full.startswith(WORKSPACE_ROOT):
        return json.dumps({"error": "Path is outside the workspace."})
    if not os.path.isfile(full):
        return json.dumps({"error": f"File not found: {path}"})
    with open(full, "r", encoding="utf-8", errors="replace") as f:
        content = f.read()
    return json.dumps({"path": path, "content": content})


@mcp.tool()
def search_sql_files(keyword: str, folder: str | None = None) -> str:
    """Search for SQL files whose content or filename contains a keyword.

    Args:
        keyword: The search term (case-insensitive).
        folder: Optional folder to scope the search (relative to workspace root).
    """
    base = WORKSPACE_ROOT if not folder else os.path.join(WORKSPACE_ROOT, folder)
    pattern = os.path.join(base, "**", "*.sql")
    files = glob.glob(pattern, recursive=True)
    keyword_lower = keyword.lower()
    matches = []
    for f in sorted(files):
        rel = os.path.relpath(f, WORKSPACE_ROOT).replace("\\", "/")
        if keyword_lower in rel.lower():
            matches.append({"file": rel, "match": "filename"})
            continue
        try:
            with open(f, "r", encoding="utf-8", errors="replace") as fh:
                content = fh.read()
            if keyword_lower in content.lower():
                # Extract first matching line for context
                for line in content.splitlines():
                    if keyword_lower in line.lower():
                        matches.append({"file": rel, "match": "content", "line": line.strip()})
                        break
        except Exception:
            pass
    return json.dumps(matches[:50], indent=2)


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    mcp.run(transport="stdio")
