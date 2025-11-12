# SQL Developer Basics - README

## 📚 Overview

This repository contains a comprehensive collection of SQL Server T-SQL scripts covering fundamental to advanced database concepts. It's designed as a learning resource for SQL developers, organized by topic with practical examples.

## 📁 Repository Structure

The scripts are organized sequentially and cover the following topics:

### Core Concepts
- **Database & Table Operations**: `003.CreateAndDropDatabase.sql`, `005.CreateAndDropTable.sql`
- **Data Manipulation**: `006.InsertInto.sql`, `023.UpdateRowsInTable.sql`, `024.DeleteRowsFromTable.sql`
- **Data Retrieval**: `007.Select.sql`, `009.GetUniqueValues.sql`

### Data Filtering & Sorting
- `010.SortData.sql` - ORDER BY clause
- `011.Comments.sql` - SQL commenting
- `012.FilterData.sql` - WHERE clause with AND/OR/IN operators
- `013.FilterWithWildCharacters.sql` - LIKE patterns with wildcards

### Aggregate Functions & Grouping
- `014.AggregateFunctions.sql` - SUM, AVG, MIN, MAX, COUNT
- `015.GroupingRows.sql` - GROUP BY clause
- `060.HAVING Clause.sql` - Filtering grouped data

### Table Constraints
- `017.CreateTableWithPrimaryKey.sql`
- `018.CreateTableWithNOTNULLConstraint.sql`
- `019.CreateTableWithUniqueConstraint.sql`
- `020.CreateTableWithCheckConstraint.sql`
- `021.CreateTableWithDefaultConstraing.sql`
- `053.Foriegn Key constraint.sql`

### Auto-Increment & Identity
- `022.CreateTableWithAutoIncrement.sql`
- `022.CreateTableWithAutoIncrement2.sql`
- `022.CreateTableWithAutoIncrement3.sql`

### String & Date Functions
- `025.StringFunctions-Part1.sql` - UPPER, LOWER, LEFT, RIGHT, LEN, TRIM
- `026.StringFunctions-Part2.sql` - REPLACE, REVERSE, STUFF
- `029.DateTimeFunctions-Part1.sql` - GETDATE, DATEFROMPARTS
- `030.DateTimeFunctions-Part2.sql` - YEAR, MONTH, DAY, FORMAT
- `031.DateTimeFunctions-Part3.sql` - DATEADD, DATEDIFF, EOMONTH

### Data Types
- `032.Datatypes-Part1-Integers.sql`
- `033.Datatypes-Part2-ApproximateNumeric.sql`
- `035.Datatypes-Part4-Strings.sql`
- `036.Datatypes-Part4-Uniqueidentifier.sql`
- `037.Datatypes-Part5-bit.sql`

### Joins
- `039.Introduction to joins.sql`
- `040.Joins Part2 - Using joins.sql`
- `041.Joins Part3 - Join 3 tables.sql`
- `043.Joins Part5 - Outer Joins.sql`
- `044.Scenario - Joins Part6 - Self Join.sql`

### Conditional Logic
- `046.IIF Function.sql`
- `047.CASE.sql`
- `048.IIF & CASE multiple conditions.sql`

### Set Operations
- `050.UNION & UNION ALL.sql`
- `051.INTERSECT.sql`
- `052.EXCEPT.sql`

### Subqueries
- `054-Subquery - PART1.sql`
- `055.Subquery-PART2-Using IN & NOT IN.sql`
- `057.Subquery-PART4-Derived Table.sql`
- `058.Subquery-PART5-EXISTS, NOT EXISTS, Correlated Subquery.sql`

### Advanced Features
- `063.Window Functions-PART1-ROWNUMBER.sql`
- `064.Window Functions-PART2-RANK & DENSE_RANK.sql`
- `065.Window Functions-PART3-LAG & LEAD.sql`
- `066.Window Functions-PART4-FIRST_VALUE & LAST_VALUE.sql`
- `072.MERGE.sql`
- `074.GROUP BY WITH ROLLUP.sql`
- `075.GROUP BY WITH CUBE.sql`
- `076.PIVOT.sql`
- `077.UNPIVOT.sql`

### Database Objects
- `078.VIEWS.sql`
- `079.CommonTableExpression-Part1-Introduction.sql`
- `080.CommonTableExpression-PART2-MultiPArtCTE.sql`
- `081.CommonTableExpression-PART3-Recursion.sql`
- `086.StoredProcedures.sql`

### Advanced Topics
- `082.Variables.sql`
- `083.IF..ELSE.sql`
- `084.WHILE LOOP.sql`
- `087.Converting a table to JSON.sql`
- `088.CreatingNestedJsonOutput.sql`
- `089.OUTPUT.sql`
- `090.SCD.sql` - Slowly Changing Dimensions
- `091.Indexes-Part1.sql`
- `092.Indexes-Part2.sql`
- `093.Indexes-Part3.sql`
- `094.Indexes-Part4.sql`

## 🎯 Key Topics Covered

✅ CRUD Operations (Create, Read, Update, Delete)  
✅ Data Types and Constraints  
✅ Joins (INNER, LEFT, RIGHT, FULL OUTER, SELF)  
✅ Aggregate Functions (SUM, AVG, COUNT, MIN, MAX)  
✅ Grouping and Filtering (GROUP BY, HAVING, WHERE)  
✅ String and Date Functions  
✅ Subqueries and Common Table Expressions (CTEs)  
✅ Window Functions (ROW_NUMBER, RANK, LAG, LEAD)  
✅ Set Operations (UNION, INTERSECT, EXCEPT)  
✅ Views and Stored Procedures  
✅ Indexes and Performance  
✅ Slowly Changing Dimensions (SCD)  
✅ JSON Output  
✅ Control Flow (IF/ELSE, WHILE)  
✅ Variables and MERGE statements  

## 🚀 Getting Started

1. Open any `.sql` file in SQL Server Management Studio (SSMS)
2. Execute the scripts against your SQL Server instance
3. Review the output and modify queries as needed for learning

## 📝 Prerequisites

- SQL Server 2012 or later
- SQL Server Management Studio (SSMS)
- Basic understanding of relational databases (recommended)

## 💡 Usage Tips

- Scripts are numbered sequentially for a recommended learning path
- Each file contains standalone examples with comments
- Scripts use sample tables like `DimProduct`, `FactInternetSales`, `DimEmployee` (typically from AdventureWorks database)
- Modify table names and values as needed for your environment

## 📚 Learning Path

**Beginner**: Scripts 003-015 (Basics)  
**Intermediate**: Scripts 016-060 (Joins, Functions, Subqueries)  
**Advanced**: Scripts 061-094 (Window Functions, CTEs, Indexes, SCD)

## 🤝 Contributing

Feel free to add more examples or improve existing scripts!

---

**Happy Learning! 🎓  