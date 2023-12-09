USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.is_table_type = 1 AND t.[name] = N'scheme_preference_add_list' AND s.[name] = 'COMMON')
BEGIN 
	DROP TYPE COMMON.scheme_preference_add_list
	PRINT '########## COMMON.scheme_preference_add_list dropped successfully ##########'
END
GO

CREATE TYPE COMMON.scheme_preference_add_list AS TABLE   
(
	abbrev			char(4),
	attr_weight		int,
	l2_desc			varchar(50),
	preference		int
)
GO  
PRINT '########## COMMON.scheme_preference_add_list created successfully ##########'
