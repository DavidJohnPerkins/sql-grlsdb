USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_analysis_pivot') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_analysis_pivot
	PRINT '########## GRLS.v_analysis_pivot dropped successfully ##########'
END
GO

DECLARE @sql 		varchar(MAX),
		@pivotlist 	varchar(MAX)

SET @sql = '
	CREATE VIEW GRLS.v_analysis_pivot AS	
		SELECT
			piv.*
		FROM
		(
			SELECT
				ba.scheme_abbrev,
				ba.model_id,
				ba.principal_name,
				ba.nationality,
				ba.adjusted_total,
				ba.hotness_quotient,
				ba.abbrev,
				CONVERT(varchar(255), ba.l2_desc + ^ (^ + CONVERT(varchar, ba.adj_preference) + GRLS.format_standout_factor(ba.standout_factor) + ^)^) AS x
			FROM
				GRLS.v_basic_analysis ba
			WHERE
				ba.for_aggregation = 1
			) d
		PIVOT
		(
			MAX(x)
		FOR d.abbrev IN(~pivotlist)
	) piv;'
	SET @sql = REPLACE(@sql, '~pivotlist', GRLS.l1_abbrevs_as_string()) 
	SET @sql = REPLACE(@sql, '^', '''');

	EXEC (@sql)
GO
PRINT '########## GRLS.v_analysis_pivot created successfully ##########'
