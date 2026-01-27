SELECT 
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    CASE WHEN pk.is_primary_key = 1 THEN 'YES' ELSE 'NO' END AS IsPrimaryKey,
    fk.name AS ForeignKeyName,
    ref_t.name AS ReferencedTable,
    ref_c.name AS ReferencedColumn
FROM sys.schemas s
JOIN sys.tables t ON s.schema_id = t.schema_id
JOIN sys.columns c ON t.object_id = c.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
LEFT JOIN (
    SELECT i.object_id, ic.column_id, i.is_primary_key
    FROM sys.indexes i
    JOIN sys.index_columns ic 
        ON i.object_id = ic.object_id AND i.index_id = ic.index_id
    WHERE i.is_primary_key = 1
) pk ON c.object_id = pk.object_id AND c.column_id = pk.column_id
LEFT JOIN sys.foreign_key_columns fkc 
    ON c.object_id = fkc.parent_object_id AND c.column_id = fkc.parent_column_id
LEFT JOIN sys.foreign_keys fk 
    ON fkc.constraint_object_id = fk.object_id
LEFT JOIN sys.tables ref_t 
    ON fkc.referenced_object_id = ref_t.object_id
LEFT JOIN sys.columns ref_c 
    ON fkc.referenced_object_id = ref_c.object_id 
   AND fkc.referenced_column_id = ref_c.column_id
WHERE t.name in ('Customer','Person','PersonPhone','EmailAddress','AddressType','BusinessEntityAddress',
'Address','Employee','Department','EmployeeDepartmentHistory','Product','ProductModel','ProductCategory',
'ProductSubcategory')
ORDER BY SchemaName, TableName, ColumnName;