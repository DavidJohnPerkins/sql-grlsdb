USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.v_attribute_level_2
GO

CREATE VIEW GRLS.v_attribute_level_2 AS

SELECT
	l2.l2_id,
	l2.l1_id,
	l1.abbrev,
	l2.l2_desc
FROM
	GRLS.attribute_level_2 l2
	INNER JOIN GRLS.attribute_level_1 l1 
	ON l2.l1_id = l1.l1_id
