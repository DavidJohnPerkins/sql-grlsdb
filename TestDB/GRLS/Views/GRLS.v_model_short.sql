USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_model_short') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_model_short
	PRINT '########## GRLS.v_model_short dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_model_short AS

	SELECT 
		m.id,
		m.sobriquet,
		mn.model_name AS principal_name,
		m.hotness_quotient,
		m.is_excluded,
		al.l2_desc AS nationality,
		f.flags,
		img.TH_url
	FROM
		GRLS.model m
		INNER JOIN GRLS.model_name mn 
		ON m.id = mn.model_id AND mn.principal_name = 1
		OUTER APPLY (
			SELECT
				i.TH_url
			FROM
				GRLS.v_image_url_pivot i
			WHERE 
				i.model_id = m.id
		) img
		OUTER APPLY (
			SELECT
				STRING_AGG(x.flag_abbrev, '/') AS flags
			FROM (
				SELECT
					fl.flag_abbrev
				FROM 
					GRLS.model_flag mf 
					INNER JOIN GRLS.flag fl 
					ON mf.flag_id = fl.flag_id
				WHERE
					mf.model_id = m.id
				ORDER BY
					fl.flag_abbrev OFFSET 0 ROWS) x
		) f
		INNER JOIN GRLS.v_attribute_list al 
		ON m.id = al.model_id AND al.abbrev = 'NATN'
		
GO
PRINT '########## GRLS.v_model_short created successfully ##########'