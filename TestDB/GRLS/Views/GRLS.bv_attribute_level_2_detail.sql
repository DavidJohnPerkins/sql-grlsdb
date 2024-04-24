USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.bv_attribute_level_2_detail') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.bv_attribute_level_2_detail
	PRINT '########## GRLS.bv_attribute_level_2_detail dropped successfully ##########'
END
GO

CREATE VIEW GRLS.bv_attribute_level_2_detail AS

SELECT
	l2.l2_id,
	l2.l1_id,
	l2d.l2_preference,
	l2d.scheme_id,
	l2d.l2_det_id
FROM
	GRLS.attribute_level_2 l2
	INNER JOIN GRLS.attribute_level_2_detail l2d
	ON l2.l2_id = l2d.l2_id
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Base view returning level 2 attribute with preference by scheme.',
    @level0type = 'SCHEMA', @level0name = N'GRLS',
    @level1type = 'VIEW', @level1name = N'bv_attribute_level_2_detail';
GO

PRINT '########## GRLS.bv_attribute_level_2_detail created successfully ##########'
