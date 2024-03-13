SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_analysis_base') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_analysis_base
	PRINT '########## GRLS.v_analysis_base dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_analysis_base AS

	WITH w_env AS  (
		SELECT CASE COMMON.environment_value('USE_STANDOUT', 'FALSE') WHEN 'TRUE' THEN 1 ELSE 0 END AS use_so
	),
	w_work AS (
		SELECT
			att.scheme_id,
			att.scheme_abbrev,
			ma.id AS ma_attr_id,
			CASE w.use_so WHEN 1 THEN ma.standout_factor ELSE 1 END AS standout_factor,
			m.id AS model_id ,
			m.principal_name,
			m.sobriquet ,
			m.hotness_quotient,
			m.nationality,
			att.abbrev ,
			att.l2_desc ,
			CONVERT(float, att.l2_preference) AS l2_preference ,
			CONVERT(float, att.attr_weight) / 10 AS attr_weight ,
			att.for_aggregation
		FROM
			GRLS.v_model_extended m
			INNER JOIN GRLS.model_attribute ma
				INNER JOIN GRLS.v_attribute att
				ON ma.attribute_id = att.l2_id
			ON m.id = ma.model_id,
			w_env w
		WHERE
			att.for_aggregation = 1 AND 
			att.active = 1 AND 
			ma.valid_to IS NULL
	)
	SELECT
		w.* ,
		w.l2_preference * (1 + w.attr_weight) AS adj_preference
	FROM
		w_work w 
		
GO
PRINT '########## GRLS.v_analysis_base created successfully ##########'
