USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.is_table_type = 1 AND t.[name] = N'name_add_list' AND s.[name] = 'COMMON')
BEGIN 
	DROP TYPE COMMON.name_add_list
	PRINT '########## COMMON.name_add_list dropped successfully ##########'
END
GO

CREATE TYPE COMMON.name_add_list AS TABLE   
(
	model_name		varchar(50),
	principal_name	bit
)
GO  
PRINT '########## COMMON.name_add_list created successfully ##########'
