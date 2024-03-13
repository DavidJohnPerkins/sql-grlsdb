USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_image_list') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_image_list
	PRINT '########## GRLS.v_image_list dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_image_list AS

	SELECT
		m.sobriquet,
		l1.ia_l1_desc,
		l2.ia_l2_desc,
		im.reference_image
	FROM 
		GRLS.image_model im
		INNER JOIN GRLS.model m 
		ON im.model_id = m.id
		INNER JOIN GRLS.image_attribute ia 
			INNER JOIN GRLS.image_attribute_level_2 l2 
				INNER JOIN GRLS.image_attribute_level_1 l1 
				ON l2.ia_l1_id = l1.ia_l1_id
			ON ia.image_attr_l2_id = l2.ia_l2_id
		ON im.image_id = ia.image_id
GO
PRINT '########## GRLS.v_image_list created successfully ##########'
