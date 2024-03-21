USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.bv_attribute_level_1_detail') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.bv_attribute_level_1_detail
	PRINT '########## GRLS.bv_attribute_level_1_detail dropped successfully ##########'
END
GO

CREATE VIEW GRLS.bv_attribute_level_1_detail AS

SELECT
	l1.l1_id,
	l1.for_aggregation,
	l1d.attr_weight,
	l1d.scheme_id,
	s.active
FROM
	GRLS.attribute_level_1 l1
	INNER JOIN GRLS.attribute_level_1_detail l1d
		INNER JOIN GRLS.attribute_scheme s 
		ON l1d.scheme_id = s.scheme_id
	ON l1.l1_id = l1d.l1_id
		
GO
PRINT '########## GRLS.bv_attribute_level_1_detail created successfully ##########'
