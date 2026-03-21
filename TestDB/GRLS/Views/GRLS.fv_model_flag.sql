USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.fv_model_flag') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.fv_model_flag
	PRINT '########## GRLS.fv_model_flag dropped successfully ##########'
END
GO

CREATE VIEW GRLS.fv_model_flag AS

	SELECT 
		f.*
	FROM 
		GRLS.flag f
	WHERE 
		f.flag_type = 1
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Base view returning model flags.',
    @level0type = 'SCHEMA', @level0name = N'GRLS',
    @level1type = 'VIEW', @level1name = N'fv_model_flag';
GO

PRINT '########## GRLS.fv_model_flag created successfully ##########'
