USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.basic_analysis
GO

CREATE VIEW GRLS.basic_analysis AS

	WITH w_work AS (
		SELECT
			m.id AS model_id ,
			m.sobriquet ,
			m.hotness_quotient,
			al1.abbrev ,
			al2.l2_desc ,
			CONVERT(float, al2.l2_preference) AS l2_preference ,
			CONVERT(float, al1.attr_weight) / 10 AS attr_weight
		FROM
			GRLS.model m
			INNER JOIN GRLS.model_attribute ma
				INNER JOIN GRLS.attribute_level_2 al2
					INNER JOIN GRLS.attribute_level_1 al1
					ON al2.l1_id = al1.l1_id
				ON ma.attribute_id = al2.l2_id
			ON m.id = ma.model_id
		WHERE
			al1.for_aggregation = 1
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
			w.model_id ,
			w.sobriquet ,
			w.hotness_quotient,
			w.attr_weight,
			w.abbrev ,
			w.l2_desc ,
			w.l2_preference ,
			w.adj_preference ,
			CONVERT(decimal(5, 2), w.adj_preference / SUM(w.adj_preference) OVER (PARTITION BY w.model_id) * 100) AS [Weight] ,
			CONVERT(decimal(8, 2), SUM(w.adj_preference) OVER (PARTITION BY w.model_id)) AS Total1
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


