SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_scheme_l2_preference') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_scheme_l2_preference
	PRINT '########## GRLS.dv_scheme_l2_preference dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_scheme_l2_preference AS

	SELECT
		piv.* 
	FROM 
		(
			SELECT 
				s2.scheme_abbrev AS l2_scheme,
				l1.abbrev,
				l2.l2_desc,
				att.l2_preference x
			FROM 
				GRLS.dv_attribute_l1_l2 att
				INNER JOIN GRLS.attribute_level_1 l1 
				ON att.l1_id = l1.l1_id
				INNER JOIN GRLS.attribute_level_2 l2 
				ON att.l2_id = l2.l2_id
				INNER JOIN GRLS.attribute_scheme s2
				ON att.scheme_id_l2 = s2.scheme_id
				INNER JOIN GRLS.attribute_scheme s1
				ON att.scheme_id_l1 = s1.scheme_id
			) d
		PIVOT
		(
			MAX(x)
			FOR d.l2_scheme IN (LATEADOL, FULLERFIGURE, LATEADOLLEVEL, NOPREF, SIMPLE)
		) piv

GO
PRINT '########## GRLS.dv_scheme_l2_preference created successfully ##########'
