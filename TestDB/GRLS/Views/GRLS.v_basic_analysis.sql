USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.v_basic_analysis
GO

CREATE VIEW GRLS.v_basic_analysis AS

	WITH w_work AS (
		SELECT
			att.scheme_id,
			m.id AS model_id ,
			m.sobriquet ,
			m.hotness_quotient,
			att.abbrev ,
			att.l2_desc ,
			CONVERT(float, att.l2_preference) AS l2_preference ,
			CONVERT(float, att.attr_weight) / 10 AS attr_weight
		FROM
			GRLS.model m
			INNER JOIN GRLS.model_attribute ma
				INNER JOIN GRLS.v_attribute att
				ON ma.attribute_id = att.l2_id
			ON m.id = ma.model_id
		WHERE
			att.for_aggregation = 1 AND 
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
			w.scheme_id,
			w.model_id ,
			w.sobriquet ,
			w.hotness_quotient,
			w.attr_weight,
			w.abbrev ,
			w.l2_desc ,
			w.l2_preference ,
			w.adj_preference ,
			CONVERT(decimal(5, 2), w.adj_preference / SUM(w.adj_preference) OVER (PARTITION BY w.scheme_id, w.model_id) * 100) AS [Weight] ,
			CONVERT(decimal(8, 2), SUM(w.adj_preference) OVER (PARTITION BY w.scheme_id, w.model_id)) AS Total1
		FROM
			w_work2 w
	)
	SELECT
		w3.* ,
		ROUND(w3.Total1 * (1 + (CONVERT(float, m.hotness_quotient) / 100)), 2) AS adjusted_total
	FROM 
		w_work3 w3
		INNER JOIN GRLS.model m
		ON w3.model_id = m.id
