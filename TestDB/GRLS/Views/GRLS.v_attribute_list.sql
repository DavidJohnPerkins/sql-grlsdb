USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_attribute_list') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_attribute_list
	PRINT '########## GRLS.v_attribute_list dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_attribute_list AS

	SELECT
		ma.id,
		m.id AS model_id ,
		m.sobriquet ,
		al1.l1_id,
		al1.abbrev,
		al1.l1_desc,
		al2.l2_id,
		al2.l2_desc,
		ma.standout_factor
	FROM
		GRLS.model m
		INNER JOIN GRLS.model_attribute ma
			INNER JOIN GRLS.attribute_level_2 al2
				INNER JOIN GRLS.attribute_level_1 al1
				ON al2.l1_id = al1.l1_id
			ON ma.attribute_id = al2.l2_id
		ON m.id = ma.model_id
	WHERE 
		ma.valid_to IS NULL
GO
PRINT '########## GRLS.v_attribute_list created successfully ##########'
