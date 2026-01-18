SELECT 
    p.ProductID AS ProductAlternateKey,
    p.ProductNumber,
    p.Name AS ProductName,
    p.Color,
    p.Size,
    pm.Name AS ProductModelName,
    ps.Name AS ProductSubcategoryName,
    pc.Name AS ProductCategoryName,
    p.StandardCost,
    p.ListPrice,
    p.SellStartDate,
    p.SellEndDate
FROM Production.Product p
LEFT JOIN Production.ProductModel pm 
    ON p.ProductModelID = pm.ProductModelID
LEFT JOIN Production.ProductSubcategory ps 
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc 
    ON ps.ProductCategoryID = pc.ProductCategoryID;