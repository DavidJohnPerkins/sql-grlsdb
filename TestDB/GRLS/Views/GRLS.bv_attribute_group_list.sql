USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.bv_attribute_group_list') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.bv_attribute_group_list
	PRINT '########## GRLS.bv_attribute_group_list dropped successfully ##########'
END
GO

CREATE VIEW GRLS.bv_attribute_group_list AS

	SELECT 
		ag.l1_group_id,
		ag.l1_group_abbrev,
		agd.l1_id
	FROM 
		GRLS.attribute_level_1_group ag
		INNER JOIN GRLS.attribute_level_1_group_detail agd
		ON ag.l1_group_id = agd.l1_group_id

GO
PRINT '########## GRLS.bv_attribute_group_list created successfully ##########'