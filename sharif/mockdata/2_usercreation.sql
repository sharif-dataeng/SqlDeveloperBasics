-- Run on master (requires sysadmin)
USE [master];
GO

-- Create server-level login (if it doesn't exist)
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'yourname')
BEGIN
    CREATE LOGIN [yourname] WITH PASSWORD = 'yourpassword';
END
GO

-- Then create database user
USE [AdventureWorkMock];
GO

CREATE USER [yourname] FOR LOGIN [yourname];
GO

ALTER ROLE [db_owner] ADD MEMBER [yourname];
GO