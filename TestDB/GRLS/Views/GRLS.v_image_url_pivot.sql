USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_image_url_pivot') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_image_url_pivot
	PRINT '########## GRLS.v_image_url_pivot dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_image_url_pivot AS
	SELECT
		piv.*
	FROM
	(
		SELECT
			im.model_id,
			i.image_url,
			CASE WHEN im.thumbnail_image 	= 1 THEN 'thumbnail' ELSE 
			CASE WHEN im.reference_image 	= 1 THEN 'ref_url' ELSE 
			CASE WHEN im.f_image			= 1 THEN 'f_url' ELSE
			CASE WHEN im.b_image			= 1 THEN 'b_url' ELSE
			CASE WHEN im.p_image_f			= 1 THEN 'p1_url' ELSE
			CASE WHEN im.p_image_r			= 1 THEN 'p2_url' ELSE
			CASE WHEN im.a_image			= 1 THEN 'a_url' 
			END END END END END END END AS i_desc
		FROM
			GRLS.image_model im
			INNER JOIN GRLS.[image] i 
			ON im.image_id = i.image_id
	) d
	PIVOT
	(
		MAX(d.image_url)
		FOR d.i_desc IN (thumbnail, ref_url, f_url, b_url, p1_url, p2_url, a_url)
) piv;
GO
PRINT '########## GRLS.v_image_url_pivot created successfully ##########'
