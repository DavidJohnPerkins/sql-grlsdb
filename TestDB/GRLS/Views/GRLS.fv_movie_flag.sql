USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.fv_movie_flag') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.fv_movie_flag
	PRINT '########## GRLS.fv_movie_flag dropped successfully ##########'
END
GO

CREATE VIEW GRLS.fv_movie_flag AS

	SELECT 
		f.*
	FROM 
		GRLS.flag f
	WHERE 
		f.flag_type = 3
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Filtered view returning movie flags.',
    @level0type = 'SCHEMA', @level0name = N'GRLS',
    @level1type = 'VIEW', @level1name = N'fv_movie_flag';
GO

PRINT '########## GRLS.fv_movie_flag created successfully ##########'
