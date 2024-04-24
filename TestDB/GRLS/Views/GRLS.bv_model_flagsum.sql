USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.bv_model_flagsum') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.bv_model_flagsum
	PRINT '########## GRLS.bv_model_flagsum dropped successfully ##########'
END
GO

CREATE VIEW GRLS.bv_model_flagsum AS

	SELECT 
		m.id AS model_id,
		SUM(fb.bin_val) AS flag_sum
	FROM 
		GRLS.model m 
		INNER JOIN GRLS.model_flag mf 
			INNER JOIN GRLS.flag f 
				INNER JOIN GRLS.bv_flag_binary fb 
				ON f.flag_abbrev = fb.flag_abbrev
			ON mf.flag_id = f.flag_id
		ON m.id = mf.model_id
	GROUP BY 
		m.id

GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Base view returning model and sum of flag binary values (ie. unique to each flag combination.',
    @level0type = 'SCHEMA', @level0name = N'GRLS',
    @level1type = 'VIEW', @level1name = N'bv_model_flagsum';
GO

PRINT '########## GRLS.bv_model_flagsum created successfully ##########'
