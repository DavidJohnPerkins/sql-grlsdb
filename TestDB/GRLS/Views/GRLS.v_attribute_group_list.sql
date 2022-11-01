USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_attribute_group_list') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_attribute_group_list
	PRINT '########## GRLS.v_attribute_group_list dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_attribute_group_list AS

	SELECT 
		ag.l1_group_abbrev,
		ag.l1_group_desc,
		agd.l1_id,
		al1.abbrev,
		al1.l1_desc
	FROM 
		GRLS.attribute_level_1_group ag
		INNER JOIN GRLS.attribute_level_1_group_detail agd
			INNER JOIN GRLS.attribute_level_1 al1
			ON agd.l1_id = al1.l1_id
		ON ag.l1_group_id = agd.l1_group_id

GO
PRINT '########## GRLS.v_attribute_group_list created successfully ##########'
