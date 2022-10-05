USE TestDB
GO

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

CREATE VIEW GRLS.v_basic_analysis AS

	WITH w_work AS (
		SELECT
			att.scheme_id,
			m.id AS model_id ,
			mn.model_name,
			m.sobriquet ,
			m.hotness_quotient,
			att.abbrev ,
			att.l2_desc ,
			CONVERT(float, att.l2_preference) AS l2_preference ,
			CONVERT(float, att.attr_weight) / 10 AS attr_weight ,
			att.for_aggregation
		FROM
			GRLS.model m
			INNER JOIN GRLS.model_attribute ma
				INNER JOIN GRLS.model_name mn
				ON ma.model_id = mn.model_id AND mn.principal_name = 1
				INNER JOIN GRLS.v_attribute att
				ON ma.attribute_id = att.l2_id
			ON m.id = ma.model_id
		WHERE
			--att.for_aggregation = 1 AND 
			att.active = 1
	) ,
	w_work2 AS (
		SELECT
			w.* ,
			w.l2_preference * (1 + w.attr_weight) AS adj_preference
		FROM
			w_work w
	) ,
	w_work3 AS
	(
		SELECT
			w2.scheme_id,
			w2.model_id ,
			w2.model_name,
			w2.sobriquet ,
			w2.hotness_quotient,
			w2.attr_weight,
			w2.abbrev ,
			w2.l2_desc ,
			w2.l2_preference ,
			w2.adj_preference ,
			w2.for_aggregation,
			CONVERT(decimal(5, 2), w2.adj_preference / SUM(w2.adj_preference) OVER (PARTITION BY w2.scheme_id, w2.model_id) * 100) AS [Weight] ,
			CONVERT(decimal(8, 2), SUM(w2.adj_preference) OVER (PARTITION BY w2.scheme_id, w2.model_id)) AS Total1
		FROM
			w_work2 w2
	)
	SELECT
		w3.* ,
		ROUND(w3.Total1 * (1 + (CONVERT(float, m.hotness_quotient) / 100)), 2) AS adjusted_total
	FROM 
		w_work3 w3
		INNER JOIN GRLS.model m
		ON w3.model_id = m.id
GO
PRINT '########## GRLS.v_basic_analysis created successfully ##########'
