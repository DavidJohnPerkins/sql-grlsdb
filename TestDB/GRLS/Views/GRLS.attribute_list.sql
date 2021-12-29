USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.attribute_list
GO

CREATE VIEW GRLS.attribute_list AS

	SELECT
		ma.id,
		m.id AS model_id ,
		m.sobriquet ,
		al1.l1_id,
		al1.l1_desc,
		al2.l2_id,
		al2.l2_desc
	FROM
		GRLS.model m
		INNER JOIN GRLS.model_attribute ma
			INNER JOIN GRLS.attribute_level_2 al2
				INNER JOIN GRLS.attribute_level_1 al1
				ON al2.l1_id = al1.l1_id
			ON ma.attribute_id = al2.l2_id
		ON m.id = ma.model_id
