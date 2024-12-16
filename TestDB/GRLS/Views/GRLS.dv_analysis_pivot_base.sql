USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_analysis_pivot_base') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_analysis_pivot_base
	PRINT '########## GRLS.v_attribute dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_analysis_pivot_base AS

	SELECT
		s.scheme_abbrev,
		ma.model_id,
		nm.model_name,
		n.nationality,
		ISNULL(f.flags, '') AS flags,
		adj.adjusted_total,
		l1.abbrev AS l1_abbrev,
		CONVERT(varchar(255), 
			l2.l2_desc + ' ' + 
			COMMON.paren(CONVERT(varchar, ma.adj_preference) +
			GRLS.format_standout_factor(ma.standout_factor))) AS x
	FROM
		GRLS.dv_model_attribute_list ma 
		INNER JOIN GRLS.dv_model_adjusted_total adj
		ON ma.model_id = adj.model_id AND ma.scheme_id_l1 = adj.scheme_id_l1 
			AND ma.is_excluded = adj.is_excluded AND ma.for_aggregation = adj.for_aggregation
		INNER JOIN GRLS.attribute_scheme s 
		ON ma.scheme_id_l1 = s.scheme_id
		INNER JOIN GRLS.attribute_level_1 l1 
		ON ma.l1_id = l1.l1_id
		INNER JOIN GRLS.attribute_level_2 l2
		ON ma.l2_id = l2.l2_id
		OUTER APPLY (
			SELECT
				mn.model_name
			FROM 
				GRLS.model_name mn
			WHERE
				mn.model_id = ma.model_id AND 
				mn.is_principal_name = 1
		) nm
		OUTER APPLY (
			SELECT 
				l21.l2_desc AS nationality
			FROM 
				GRLS.model_attribute ma1 
				INNER JOIN GRLS.attribute_level_2 l21
					INNER JOIN GRLS.attribute_level_1 l11
					ON l21.l1_id = l11.l1_id
				ON ma1.attribute_id = l21.l2_id
			WHERE 
				ma.model_id = ma1.model_id AND
				l11.abbrev = 'NATN'
		) n
		OUTER APPLY (
			SELECT
				STRING_AGG(x.flag_letter, '') AS flags
			FROM (
				SELECT
					fl.flag_letter
				FROM 
					GRLS.model_flag mf 
					INNER JOIN GRLS.flag fl 
					ON mf.flag_id = fl.flag_id
				WHERE
					mf.model_id = ma.model_id
				ORDER BY
					fl.flag_letter OFFSET 0 ROWS) x
		) f
	WHERE
		l1.for_aggregation = 1

GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Derived view returning model analysis data for subsequent pivoting.',
    @level0type = 'SCHEMA', @level0name = N'GRLS',
    @level1type = 'VIEW', @level1name = N'dv_analysis_pivot_base';
GO

PRINT '########## GRLS.dv_analysis_pivot_base created successfully ##########'
