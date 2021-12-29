WITH w_work AS (
	SELECT
		m.id AS model_id ,
		m.sobriquet ,
		al1.abbrev ,
		al2.l2_desc ,
		CONVERT(float, al2.l2_preference) AS l2_preference ,
		CONVERT(float, al1.attr_weight) / 10 AS attr_weight
	FROM
		Grls.model m
		INNER JOIN Grls.model_attribute ma
			INNER JOIN Grls.attribute_level_2 al2
				INNER JOIN Grls.attribute_level_1 al1
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
		w.abbrev ,
		w.l2_desc ,
		w.l2_preference ,
		w.adj_preference ,
		CONVERT(decimal(5, 2), w.adj_preference / SUM(w.adj_preference) OVER (PARTITION BY w.model_id) * 100) AS [Weight] ,
		CONVERT(decimal(8, 2), SUM(w.adj_preference) OVER (PARTITION BY w.model_id)) AS Total
	FROM
		w_work2 w
)
SELECT
	w3.* ,
	w3.Total ,
	w3.Total * (1 + (CONVERT(float, m.hotness_quotient) / 100)) AS adjusted_total
FROM 
	w_work3 w3
	INNER JOIN Grls.model m
	ON w3.model_id = m.id
ORDER BY 
	adjusted_total DESC ,
	w3.sobriquet ,
	[Weight] DESC

/*SELECT
	al1.l1_id ,
	al1.abbrev ,
	SUM(al2.l2_preference)
FROM
	Grls.attribute_level_1 al1
	INNER JOIN Grls.attribute_level_2 al2
	ON al1.l1_id = al2.l1_id
GROUP BY
	al1.l1_id ,
	al1.abbrev
ORDER BY
	al1.abbrev*/
