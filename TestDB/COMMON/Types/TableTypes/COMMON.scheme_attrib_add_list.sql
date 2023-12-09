USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.is_table_type = 1 AND t.[name] = N'scheme_attrib_add_list' AND s.[name] = 'COMMON')
BEGIN 
	DROP TYPE COMMON.scheme_attrib_add_list
	PRINT '########## COMMON.scheme_attrib_add_list dropped successfully ##########'
END
GO

CREATE TYPE COMMON.scheme_attrib_add_list AS TABLE   
(
	scheme_abbrev	varchar(20),
	scheme_desc		varchar(50),
	active			bit
)
GO  
PRINT '########## COMMON.scheme_attrib_add_list created successfully ##########'
