USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.is_table_type = 1 AND t.[name] = N'attrib_add_list' AND s.[name] = 'COMMON')
BEGIN 
	DROP TYPE COMMON.attrib_add_list
	PRINT '########## COMMON.attrib_add_list dropped successfully ##########'
END
GO

CREATE TYPE COMMON.attrib_add_list AS TABLE   
(
	abbrev			char(4),
	standout_factor	float,
	l2_desc			varchar(50),
	selected 		bit
)
GO  
PRINT '########## COMMON.attrib_add_list created successfully ##########'
