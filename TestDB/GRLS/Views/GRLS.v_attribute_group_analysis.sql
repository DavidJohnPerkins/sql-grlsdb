USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_attribute_group_analysis') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_attribute_group_analysis
	PRINT '########## GRLS.v_attribute_group_analysis dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_attribute_group_analysis AS

	WITH w_main AS (
		SELECT 
			ba.scheme_id,
			gl.l1_group_abbrev,
			ba.sobriquet,
			ba.abbrev,
			ba.l2_desc,
			ba.adj_preference
		FROM
			GRLS.v_analysis_base ba 
			INNER JOIN GRLS.v_attribute_group_list gl 
			ON ba.abbrev = gl.abbrev
	),
	w_total AS (
		SELECT
			w.scheme_id,
			w.l1_group_abbrev,
			w.sobriquet,
			SUM(w.adj_preference) AS adj_total
		FROM 
			w_main w
		GROUP BY 
			w.scheme_id,
			w.l1_group_abbrev,
			w.sobriquet
	)
	SELECT 
		m.*,
		t.adj_total
	FROM 
		w_main m 
		INNER JOIN w_total t 
		ON m.scheme_id = t.scheme_id AND m.l1_group_abbrev = t.l1_group_abbrev AND m.sobriquet = t.sobriquet

GO
PRINT '########## GRLS.v_attribute_group_analysis created successfully ##########'
