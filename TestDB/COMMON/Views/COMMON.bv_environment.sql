USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.bv_environment') AND [type] IN ('V'))
BEGIN 
	DROP VIEW COMMON.bv_environment
	PRINT '########## COMMON.bv_environment dropped successfully ##########'
END
GO

CREATE VIEW COMMON.bv_environment AS

		SELECT 
			CASE COMMON.environment_value('USE_STANDOUT', 'FALSE') WHEN 'TRUE' THEN 1 ELSE 0 END AS use_so,
			CASE COMMON.environment_value('SHOW_EXCLUDED_MODEL', 'FALSE') WHEN 'TRUE' THEN 1 ELSE 0 END AS show_excluded

GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Base view returning environment variable values.',
    @level0type = 'SCHEMA', @level0name = N'COMMON',
    @level1type = 'VIEW', @level1name = N'bv_environment';
GO

PRINT '########## COMMON.bv_environment created successfully ##########'
