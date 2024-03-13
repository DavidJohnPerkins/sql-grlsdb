USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.is_table_type = 1 AND t.[name] = N'flag_add_list' AND s.[name] = 'COMMON')
BEGIN 
	DROP TYPE COMMON.flag_add_list
	PRINT '########## COMMON.flag_add_list dropped successfully ##########'
END
GO

CREATE TYPE COMMON.flag_add_list AS TABLE   
(
	flag_abbrev		varchar(8)
)
GO  
PRINT '########## COMMON.flag_add_list created successfully ##########'
