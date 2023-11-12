WITH w_rank AS (
	SELECT DISTINCT
		ga.l1_group_abbrev,
		ga.sobriquet,
		ga.adj_total,
		DENSE_RANK() OVER (PARTITION BY ga.l1_group_abbrev ORDER BY ga.adj_total DESC) AS ranking 
	FROM 
		GRLS.v_attribute_group_analysis ga 
	WHERE 
		ga.scheme_id = 1
	ORDER BY 
		ga.l1_group_abbrev,
		ga.adj_total desc OFFSET 0 ROWS
),
w_total AS (
	SELECT 
		w.sobriquet,
		SUM(w.ranking) AS total_rank,
		MIN(w.ranking) AS min_rank,
		MAX(w.ranking) AS max_rank,
		AVG(w.ranking) AS avg_rank
	FROM  
		w_rank w 
	GROUP BY 
		w.sobriquet
)
SELECT 
	w2.*
FROM 
	w_total w2 
ORDER BY 
	w2.total_rank 


--select * from GRLS.v_analysis_pivot where scheme_id=1  order by adjusted_total DESC
