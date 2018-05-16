-- Query logins and log them to a table
-- This is to capture DBs that are actually in use
CREATE PROCEDURE dbo.GetDBLogins  
AS  
    SET NOCOUNT ON;  
INSERT INTO [dbo].[Usage]([login_name],[login_time],[host_name],[status],[program_name],[database_name])
SELECT s.[login_name], s.[login_time], s.[host_name], s.[status], s.[program_name], db.[name]
FROM sys.dm_exec_sessions s
     INNER JOIN sys.databases db ON s.[database_id] = db.[database_id]
WHERE s.[login_name] <> 'sa' AND s.[database_id] > 4;
GO