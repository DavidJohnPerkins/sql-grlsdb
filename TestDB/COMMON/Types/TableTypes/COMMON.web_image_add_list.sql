USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.is_table_type = 1 AND t.[name] = N'web_image_add_list' AND s.[name] = 'COMMON')
BEGIN 
	DROP TYPE COMMON.web_image_add_list
	PRINT '########## COMMON.web_image_add_list dropped successfully ##########'
END
GO

CREATE TYPE COMMON.web_image_add_list AS TABLE   
(
	image_url			GRLS.image_url,
	image_type_abbrev	char(2),
	is_mono				bit
)
GO  
PRINT '########## COMMON.web_image_add_list created successfully ##########'
