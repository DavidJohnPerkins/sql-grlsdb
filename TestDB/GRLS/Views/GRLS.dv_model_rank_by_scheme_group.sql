USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_model_rank_by_scheme_group') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_model_rank_by_scheme_group
	PRINT '########## GRLS.dv_model_rank_by_scheme_group dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_model_rank_by_scheme_group AS

	WITH w_env AS  (
		SELECT CASE COMMON.environment_value('USE_STANDOUT', 'FALSE') WHEN 'TRUE' THEN 1 ELSE 0 END AS use_so
	),
	w_level1 AS (
		SELECT
			att.scheme_id_l1,
			CASE w.use_so WHEN 1 THEN ma.standout_factor ELSE 1 END AS standout_factor,
			gd.l1_group_id,
			m.id AS model_id ,
			m.hotness_quotient,
			att.adj_preference
		FROM
			GRLS.model m
			INNER JOIN GRLS.model_attribute ma
				INNER JOIN GRLS.dv_attribute_l1_l2 att
					INNER JOIN GRLS.attribute_level_1_group_detail gd
					ON att.l1_id = gd.l1_id
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
			w1.l1_group_id,
			w1.model_id,
			w1.hotness_quotient,
			CONVERT(decimal(8, 2), SUM(w1.adj_preference * w1.standout_factor) OVER (PARTITION BY w1.scheme_id_l1, w1.l1_group_id, w1.model_id)) AS total1
		FROM 
			w_level1 w1
	),
	w_level3 AS (
		SELECT
			w2.scheme_id_l1,
			w2.l1_group_id,
			w2.model_id,
			ROUND(w2.total1 * (1 + (CONVERT(float, w2.hotness_quotient) / 100)), 2) AS adjusted_total
		FROM 
			w_level2 w2
	)
	SELECT
		w3.scheme_id_l1,
		w3.l1_group_id,
		w3.model_id,
		DENSE_RANK() OVER (PARTITION BY w3.scheme_id_l1, w3.l1_group_id ORDER BY w3.scheme_id_l1, w3.l1_group_id, w3.adjusted_total DESC) AS rank
	FROM 
		w_level3 w3 
		
GO
PRINT '########## GRLS.dv_model_rank_by_scheme_group created successfully ##########'
