USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.pv_analysis_pivot') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.pv_analysis_pivot
	PRINT '########## GRLS.pv_analysis_pivot dropped successfully ##########'
END
GO

DECLARE @sql 		varchar(MAX),
		@pivotlist 	varchar(MAX)

SET @sql = '
	CREATE VIEW GRLS.pv_analysis_pivot AS	
		SELECT 			
			DENSE_RANK() OVER (PARTITION BY piv.scheme_abbrev ORDER BY piv.adjusted_total DESC) AS rnk,
			piv.*
		FROM
		GRLS.dv_analysis_pivot_base b
		PIVOT
		(
			MAX(x)
			FOR b.l1_abbrev IN (ASHP,ASIZ,ATTR,BILD,BRDR,BRSH,BSIZ,CMPX,ETHN,EYES,HAIR,MONS,NPCL,NPPF,NPSH,NPSZ,PUAT,YTHF)
		) piv;'
	SET @sql = REPLACE(@sql, '~pivotlist', GRLS.l1_abbrevs_as_string('ALL')) 
	SET @sql = REPLACE(@sql, '^', '''');

	EXEC (@sql)
GO
PRINT '########## GRLS.pv_analysis_pivot created successfully ##########'
