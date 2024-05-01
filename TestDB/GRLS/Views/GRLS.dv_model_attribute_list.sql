USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.dv_model_attribute_list') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.dv_model_attribute_list
	PRINT '########## GRLS.dv_model_attribute_list dropped successfully ##########'
END
GO

CREATE VIEW GRLS.dv_model_attribute_list AS

	SELECT
		ma.model_id,
		m.is_excluded,
		ma.standout_factor,
		att.scheme_id_l1,
		att.active,
		att.l1_id,
		att.for_aggregation,
		att.attr_weight,
		att.l2_id,
		att.adj_preference
	FROM
		GRLS.model_attribute ma 
		INNER JOIN GRLS.model m 
		ON ma.model_id = m.id
		INNER JOIN GRLS.dv_attribute_l1_l2 att 
		ON ma.attribute_id = att.l2_id,
		COMMON.bv_environment env
	WHERE 
		(m.is_excluded = 0 OR m.is_excluded = env.show_excluded) AND 
		ma.valid_to IS NULL

GO
PRINT '########## GRLS.dv_model_attribute_list created successfully ##########'
