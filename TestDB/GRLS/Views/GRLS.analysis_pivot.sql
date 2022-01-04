USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.analysis_pivot
GO

DECLARE @sql 		varchar(MAX),
		@pivotlist 	varchar(MAX)

SET @sql = '
	CREATE VIEW GRLS.analysis_pivot AS	
		SELECT
			piv.*
		FROM
		(
			SELECT
				ba.model_id,
				ba.sobriquet,
				ba.hotness_quotient,
				ba.abbrev,
				CONVERT(varchar(255), ba.l2_desc + ^ (^ + CONVERT(varchar, ba.adj_preference) + ^)^) AS x
			FROM
				GRLS.basic_analysis ba
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
