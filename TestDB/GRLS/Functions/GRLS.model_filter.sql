USE TestDB;  
GO  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('GRLS.model_filter', 'IF') IS NOT NULL  
	DROP FUNCTION GRLS.model_filter
	PRINT '########## GRLS.model_filter dropped successfully ##########'
GO  

CREATE FUNCTION GRLS.model_filter(@p_input_json COMMON.json)
RETURNS TABLE AS 
RETURN (

	SELECT
		a.model_id 
	FROM
		GRLS.attrib_search(@p_input_json) a
		LEFT OUTER JOIN (
			SELECT model_id FROM GRLS.flag_search(@p_input_json)) f
		ON a.model_id = f.model_id
)
GO
PRINT '########## GRLS.model_filter dropped successfully ##########'


