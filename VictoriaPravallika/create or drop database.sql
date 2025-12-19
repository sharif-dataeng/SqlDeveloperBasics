-- ============================================
-- T-SQL CREATE DATABASE Syntax
-- ============================================

-- Basic CREATE DATABASE
CREATE DATABASE DatabaseName;

-- CREATE DATABASE IF NOT EXISTS (SQL Server 2016+)
CREATE DATABASE IF NOT EXISTS DatabaseName;

-- CREATE DATABASE with file specifications
CREATE DATABASE DatabaseName
    ON PRIMARY
    (
        NAME = N'DatabaseName_Data',
        FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DatabaseName.mdf',
        SIZE = 10MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 10MB
    )
    LOG ON
    (
        NAME = N'DatabaseName_Log',
        FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DatabaseName.ldf',
        SIZE = 5MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 10MB
    );

-- CREATE DATABASE with collation
CREATE DATABASE DatabaseName
    COLLATE SQL_Latin1_General_CP1_CI_AS;

-- CREATE DATABASE with compatibility level (SQL Server 2019+)
CREATE DATABASE IF NOT EXISTS DatabaseName
    ON PRIMARY
    (NAME = N'DatabaseName_Data', FILENAME = N'C:\path\DatabaseName.mdf')
    LOG ON
    (NAME = N'DatabaseName_Log', FILENAME = N'C:\path\DatabaseName.ldf')
    CONTAINMENT = NONE;

-- ============================================
-- T-SQL DROP DATABASE Syntax
-- ============================================

-- Basic DROP DATABASE
DROP DATABASE DatabaseName;

-- DROP DATABASE IF EXISTS (SQL Server 2016+)
DROP DATABASE IF EXISTS DatabaseName;

-- DROP DATABASE with SINGLE_USER option
DROP DATABASE DatabaseName WITH ROLLBACK IMMEDIATE;

-- DROP DATABASE multiple databases
DROP DATABASE Database1, Database2, Database3; 