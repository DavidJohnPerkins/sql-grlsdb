SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_scheme_preference_detail') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_scheme_preference_detail
	PRINT '########## GRLS.v_v_scheme_preference_detail dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_scheme_preference_detail AS

	SELECT
		piv.* 
	FROM 
		(
			SELECT 
				s2.scheme_abbrev AS scheme,
				l2d.abbrev,
				s1.scheme_abbrev AS l1_scheme,
				l1d.attr_weight AS l1_attr_weight,
				l2d.l2_desc,
				l2d.l2_preference x
			FROM 
				GRLS.v_attribute_level_2_detail l2d
				INNER JOIN GRLS.attribute_scheme s2
				ON l2d.scheme_id = s2.scheme_id
				INNER JOIN GRLS.attribute_level_1_detail l1d 
					INNER JOIN GRLS.attribute_scheme s1 
					ON l1d.scheme_id = s1.scheme_id
				ON l2d.l1_id = l1d.l1_id
			) d
		PIVOT
		(
			MAX(x)
			FOR d.scheme IN (LATEADOL, FULLERFIGURE, LATEADOLLEVEL, NOPREF, SIMPLE)
		) piv

GO
PRINT '########## GRLS.v_scheme_preference_detail created successfully ##########'
