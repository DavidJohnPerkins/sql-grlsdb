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
			it.image_type_abbrev + '_url' AS i_desc
		FROM
			GRLS.image_model im
			INNER JOIN GRLS.image_type it
			ON im.image_type_id = it.image_type_id
			INNER JOIN GRLS.[image] i 
			ON im.image_id = i.image_id
	) d
	PIVOT
	(
		MAX(d.image_url)
		FOR d.i_desc IN (TH_url, RF_url, FA_url, BR_url, PF_url, PR_url, AR_url)
) piv;
GO
PRINT '########## GRLS.v_image_url_pivot created successfully ##########'
