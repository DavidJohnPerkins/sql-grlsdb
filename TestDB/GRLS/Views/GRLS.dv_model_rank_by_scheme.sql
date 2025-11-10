USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_model_rank_by_scheme') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_model_rank_by_scheme
	PRINT '########## GRLS.dv_model_rank_by_scheme dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_model_rank_by_scheme AS

	WITH w_env AS  (
		SELECT CASE COMMON.environment_value('USE_STANDOUT', 'FALSE') WHEN 'TRUE' THEN 1 ELSE 0 END AS use_so
	),
	w_level1 AS (
		SELECT
			att.scheme_id_l1,
			CASE w.use_so WHEN 1 THEN ma.standout_factor ELSE 1 END AS standout_factor,
			m.id AS model_id ,
			m.hotness_quotient,
			att.adj_preference
		FROM
			GRLS.model m
			INNER JOIN GRLS.model_attribute ma
				INNER JOIN GRLS.dv_attribute_l1_l2 att
					INNER JOIN GRLS.attribute_scheme s
					ON att.scheme_id_l1 = s.scheme_id
				ON ma.attribute_id = att.l2_id
			ON m.id = ma.model_id,
			w_env w
		WHERE
			att.for_aggregation = 1 AND
			s.active = 1 AND
			ma.valid_to IS NULL
	),
	w_level2 AS (
		SELECT DISTINCT
			w1.scheme_id_l1,
			w1.model_id,
			w1.hotness_quotient,
			CONVERT(decimal(8, 2), SUM(w1.adj_preference * w1.standout_factor) OVER (PARTITION BY w1.scheme_id_l1, w1.model_id)) AS total1
		FROM
			w_level1 w1
	),
	w_level3 AS (
		SELECT
			w2.scheme_id_l1,
			w2.model_id,
			ROUND(w2.total1 * (1 + (CONVERT(float, w2.hotness_quotient) / 100)), 2) AS adjusted_total
		FROM
			w_level2 w2
	),
	w_rank1 AS (
        SELECT
            w3.scheme_id_l1,
            w3.model_id,
            DENSE_RANK() OVER (PARTITION BY w3.scheme_id_l1 ORDER BY w3.scheme_id_l1, w3.adjusted_total DESC) AS rank
        FROM
            w_level3 w3
    )
    SELECT
            w4.scheme_id_l1,
            w4.model_id,
            w4.rank,
            MAX(w4.rank) OVER (PARTITION BY w4.scheme_id_l1 ORDER BY w4.scheme_id_l1) AS scheme_max_rank
    FROM
        w_rank1 w4
GO
PRINT '########## GRLS.dv_model_rank_by_scheme created successfully ##########'
