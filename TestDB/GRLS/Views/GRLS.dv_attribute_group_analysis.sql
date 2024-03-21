USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_attribute_group_analysis') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_attribute_group_analysis
	PRINT '########## GRLS.dv_attribute_group_analysis dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_attribute_group_analysis AS

	WITH w_main AS (
		SELECT 
			s.scheme_abbrev,
			gl.l1_group_abbrev,
			ma.model_id,
			ma.l1_id,
			ma.l2_id,
			ma.adj_preference
		FROM
			GRLS.dv_model_attribute_list ma
			INNER JOIN GRLS.attribute_scheme s 
			ON ma.scheme_id_l1 = s.scheme_id
			INNER JOIN GRLS.bv_attribute_group_list gl 
			ON ma.l1_id = gl.l1_id
		WHERE 
			ma.active = 1 AND 
			ma.for_aggregation = 1
	),
	w_total AS (
		SELECT
			w.scheme_abbrev,
			w.l1_group_abbrev,
			w.model_id,
			SUM(w.adj_preference) AS adj_total
		FROM 
			w_main w
		GROUP BY 
			w.scheme_abbrev,
			w.l1_group_abbrev,
			w.model_id
	)
	SELECT 
		m.*,
		t.adj_total
	FROM 
		w_main m 
		INNER JOIN w_total t 
		ON m.scheme_abbrev = t.scheme_abbrev AND m.l1_group_abbrev = t.l1_group_abbrev AND m.model_id = t.model_id

GO
PRINT '########## GRLS.dv_attribute_group_analysis created successfully ##########'
