SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_model_adjusted_total') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_model_adjusted_total
	PRINT '########## GRLS.dv_model_adjusted_total dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_model_adjusted_total AS

	WITH w_work AS (
		SELECT
			ma.model_id,
			ma.is_excluded,
			ma.for_aggregation,
			ma.scheme_id_l1,
			ma.active,
			SUM(ma.adj_preference * ma.standout_factor)  AS work_total
		FROM
			GRLS.dv_model_attribute_list ma
		WHERE 
			ma.for_aggregation = 1
		GROUP BY
			ma.model_id,
			ma.is_excluded,
			ma.for_aggregation,
			ma.scheme_id_l1,
			ma.active
	)
	SELECT
		w.* ,
		ROUND(w.work_total * (1 + (CONVERT(float, m.hotness_quotient) / 100)), 2) AS adjusted_total
	FROM 
		w_work w
		INNER JOIN GRLS.model m
		ON w.model_id = m.id
GO
PRINT '########## GRLS.dv_model_adjusted_total created successfully ##########'
