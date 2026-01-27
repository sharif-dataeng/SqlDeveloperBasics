-- Mock data inserts for Sales.Customer (50 rows)
-- PersonID or StoreID varied; AccountNumber unique; rowguid via NEWID(); ModifiedDate = GETDATE()
SET NOCOUNT ON;
BEGIN TRANSACTION;

INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (3, NULL, 1, 'ACCT00001', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (6, NULL, 2, 'ACCT00002', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (9, NULL, 3, 'ACCT00003', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (12, NULL, 4, 'ACCT00004', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (15, NULL, 5, 'ACCT00005', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (18, NULL, 6, 'ACCT00006', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (21, NULL, 7, 'ACCT00007', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (24, NULL, 1, 'ACCT00008', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (27, NULL, 2, 'ACCT00009', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (30, NULL, 3, 'ACCT00010', NEWID(), GETDATE());

INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (33, NULL, 4, 'ACCT00011', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (36, NULL, 5, 'ACCT00012', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (39, NULL, 6, 'ACCT00013', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (42, NULL, 7, 'ACCT00014', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (45, NULL, 1, 'ACCT00015', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (48, NULL, 2, 'ACCT00016', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (51, NULL, 3, 'ACCT00017', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (54, NULL, 4, 'ACCT00018', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (57, NULL, 5, 'ACCT00019', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (60, NULL, 6, 'ACCT00020', NEWID(), GETDATE());

INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (63, NULL, 7, 'ACCT00021', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (66, NULL, 1, 'ACCT00022', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (69, NULL, 2, 'ACCT00023', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (72, NULL, 3, 'ACCT00024', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (75, NULL, 4, 'ACCT00025', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (78, NULL, 5, 'ACCT00026', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (81, NULL, 6, 'ACCT00027', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (84, NULL, 7, 'ACCT00028', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (87, NULL, 1, 'ACCT00029', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (90, NULL, 2, 'ACCT00030', NEWID(), GETDATE());

-- Store customers (PersonID NULL)
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 1, 3, 'ACCT00031', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 2, 4, 'ACCT00032', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 3, 5, 'ACCT00033', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 4, 6, 'ACCT00034', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 5, 7, 'ACCT00035', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 6, 1, 'ACCT00036', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 7, 2, 'ACCT00037', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 8, 3, 'ACCT00038', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 9, 4, 'ACCT00039', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 10, 5, 'ACCT00040', NEWID(), GETDATE());

INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 11, 6, 'ACCT00041', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 12, 7, 'ACCT00042', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 13, 1, 'ACCT00043', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 14, 2, 'ACCT00044', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 15, 3, 'ACCT00045', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 16, 4, 'ACCT00046', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 17, 5, 'ACCT00047', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 18, 6, 'ACCT00048', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 19, 7, 'ACCT00049', NEWID(), GETDATE());
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate) VALUES (NULL, 20, 1, 'ACCT00050', NEWID(), GETDATE());

COMMIT TRANSACTION;
PRINT 'Inserted 50 mock Sales.Customer rows.';
