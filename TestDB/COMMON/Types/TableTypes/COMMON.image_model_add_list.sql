USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.is_table_type = 1 AND t.[name] = N'image_model_add_list' AND s.[name] = 'COMMON')
BEGIN 
	DROP TYPE COMMON.image_model_add_list
	PRINT '########## COMMON.image_model_add_list dropped successfully ##########'
END
GO

CREATE TYPE COMMON.image_model_add_list AS TABLE   
(
	sobriquet	GRLS.sobriquet
)
GO  
PRINT '########## COMMON.image_model_add_list created successfully ##########'
