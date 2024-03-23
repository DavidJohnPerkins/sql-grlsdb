USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.bv_model_attribute_simple') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.bv_model_attribute_simple
	PRINT '########## GRLS.bv_model_attribute_simple dropped successfully ##########'
END
GO

CREATE VIEW GRLS.bv_model_attribute_simple AS

	SELECT
		ma.model_id,
		ma.id,
		l1.l1_id,
		l1.abbrev,
		l2.l2_id,
		l2.l2_desc
	FROM
		GRLS.model_attribute ma 
		INNER JOIN GRLS.bv_attribute_level_2_detail l2d 
			INNER JOIN GRLS.attribute_level_1 l1 
			ON l2d.l1_id = l1.l1_id
			INNER JOIN GRLS.attribute_level_2 l2
			ON l2d.l2_id = l2.l2_id
		ON ma.attribute_id = l2d.l2_id
	WHERE 
		l2d.scheme_id = (SELECT MIN(s.scheme_id) FROM GRLS.attribute_scheme s)
		
GO
PRINT '########## GRLS.bv_model_attribute_simple created successfully ##########'
