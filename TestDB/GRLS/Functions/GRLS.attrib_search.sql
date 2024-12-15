USE TestDB;  
GO  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('GRLS.attrib_search', 'TF') IS NOT NULL  
	DROP FUNCTION GRLS.attrib_search
	PRINT '########## GRLS.attrib_search dropped successfully ##########'
GO  

CREATE FUNCTION GRLS.attrib_search(@p_input_json COMMON.json)
RETURNS 
@result TABLE (
	model_id int
)
AS 
BEGIN 
	DECLARE @mode char(3) = JSON_VALUE(@p_input_json, '$."search_mode_attrib"');

	WITH w_search_attribs AS (
		SELECT
			sa.abbrev 		AS abbrev,
			sa.attrib_value AS attrib_value,
			sa.selected		AS selected
		FROM 
			OPENJSON (@p_input_json, '$.search_attribs')
			WITH
			(
				abbrev			GRLS.l1_abbrev,
				attrib_value	varchar(50),
				selected		bit
			) sa
		WHERE
			sa.selected = 1
	),
	w_level_1 AS (
		SELECT  
			ma.model_id,
			SUM(CASE WHEN ma.l2_desc = w.attrib_value THEN 1 ELSE 0 END) AS score
		FROM 
			GRLS.bv_model_attribute_simple ma 
			LEFT OUTER JOIN	w_search_attribs w
			ON ma.abbrev = w.abbrev
		GROUP BY  
			ma.model_id
	)
	INSERT @result
	SELECT  
		w.model_id 
	FROM 
		w_level_1 w
	WHERE 
		((w.score != 0 AND @mode = 'ANY') OR 
		(w.score = (SELECT COUNT(DISTINCT abbrev) FROM w_search_attribs) AND @mode = 'ALL'))

	RETURN
END
GO
PRINT '########## GRLS.attrib_search dropped successfully ##########'


