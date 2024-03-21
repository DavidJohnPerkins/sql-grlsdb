USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_attribute_l1_l2') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_attribute_l1_l2
	PRINT '########## GRLS.v_attribute dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_attribute_l1_l2 AS

	SELECT
		al1.scheme_id AS scheme_id_l1,
		al1.active,
		al1.l1_id,
		al1.for_aggregation,
		al1.attr_weight,
		al2.scheme_id AS scheme_id_l2,
		al2.l2_id,
		al2.l2_preference,
		al2.l2_det_id,
		CONVERT(float, al2.l2_preference) * (1 + (CONVERT(float, al1.attr_weight) * 0.1)) AS adj_preference
	FROM 
		GRLS.bv_attribute_level_2_detail al2
		INNER JOIN GRLS.bv_attribute_level_1_detail al1
		ON al2.l1_id = al1.l1_id AND al1.scheme_id = al2.scheme_id

GO
PRINT '########## GRLS.dv_attribute_l1_l2 created successfully ##########'
