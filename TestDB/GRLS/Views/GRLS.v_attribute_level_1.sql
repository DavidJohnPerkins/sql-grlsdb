USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.v_attribute_level_1
GO

CREATE VIEW GRLS.v_attribute_level_1 AS

SELECT
	l1.l1_id,
	l1.abbrev,
	l1.l1_desc,
	l1.for_aggregation,
	l1d.attr_weight,
	l1d.scheme_id
FROM
	GRLS.attribute_level_1 l1
	INNER JOIN GRLS.attribute_level_1_detail l1d
	ON l1.l1_id = l1d.l1_id