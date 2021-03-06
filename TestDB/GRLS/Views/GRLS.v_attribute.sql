USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.v_attribute
GO

CREATE VIEW GRLS.v_attribute AS

	SELECT
		al1.scheme_id,
		sc.active,
		al1.l1_id,
		al1.abbrev,
		al1.l1_desc,
		al1.for_aggregation,
		al1.attr_weight,
		al2d.l2_id,
		al2d.l2_desc,
		al2d.l2_preference
	FROM 
		GRLS.v_attribute_level_2_detail al2d
		INNER JOIN GRLS.v_attribute_level_1 al1
			INNER JOIN GRLS.attribute_scheme sc 
			ON al1.scheme_id = sc.scheme_id
		ON al2d.l1_id = al1.l1_id AND al2d.scheme_id = al1.scheme_id
