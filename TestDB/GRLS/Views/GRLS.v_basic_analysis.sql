SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_basic_analysis') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_basic_analysis
	PRINT '########## GRLS.v_basic_analysis dropped successfully ##########'
END
GO

CREATE VIEW [GRLS].[v_basic_analysis] AS

	WITH w_work AS (
		SELECT
			ab.scheme_abbrev,
			ab.ma_attr_id,
			ab.model_id ,
			ab.principal_name,
			ab.sobriquet ,
			ab.hotness_quotient,
			ab.nationality,
			ab.attr_weight,
			ab.abbrev ,
			ab.standout_factor,
			ab.l2_desc ,
			ab.l2_preference ,
			ab.adj_preference ,
			ab.for_aggregation,
			--CONVERT(decimal(5, 2), ab.adj_preference / SUM(ab.adj_preference) OVER (PARTITION BY ab.scheme_id, ab.model_id) * 100) AS [Weight] ,
			CONVERT(decimal(8, 2), SUM(ab.adj_preference * ab.standout_factor) OVER (PARTITION BY ab.scheme_id, ab.model_id)) AS Total1
		FROM
			GRLS.v_analysis_base ab
	)
	SELECT
		w.* ,
		ROUND(w.Total1 * (1 + (CONVERT(float, m.hotness_quotient) / 100)), 2) AS adjusted_total
	FROM 
		w_work w
		INNER JOIN GRLS.model m
		ON w.model_id = m.id
GO
PRINT '########## GRLS.v_basic_analysis created successfully ##########'
