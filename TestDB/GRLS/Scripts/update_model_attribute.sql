/*
DECLARE	@sobr	GRLS.sobriquet = 'ALICE_MAY',
		@abbrev	GRLS.l1_abbrev = 'NPPF'

SELECT
	@sobr AS 'model_sobriquet',
	@abbrev AS 'l1_abbrev',
	v.l2_desc AS 'l2_desc',
	v.standout_factor
FROM
	GRLS.v_analysis_base v
WHERE
	v.sobriquet = @sobr AND 
	v.abbrev = @abbrev AND
	v.scheme_id = 1
FOR JSON PATH
*/

declare @p_input_json COMMON.json = '
	{
		"model_sobriquet": "ALICE_MAY",
		"l1_abbrev": "NPPF",
		"l2_desc": "Very Puffy",
		"standout_factor": 1.2
	}
'

	DECLARE @v_model_id	int 	= (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = (SELECT JSON_VALUE(@p_input_json, '$."model_sobriquet"'))),
			@v_li_id	int 	= (SELECT l1.l1_id FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = (SELECT JSON_VALUE(@p_input_json, '$."l1_abbrev"'))),
			@v_l2_id	int 	= (SELECT l2.l2_id FROM GRLS.attribute_level_2 l2 WHERE l2.l2_desc = (SELECT JSON_VALUE(@p_input_json, '$."l2_desc"'))),
			@v_sof		float	= (SELECT JSON_VALUE(@p_input_json, '$."standout_factor"'))


select @v_model_id,@v_li_id, @v_l2_id, @v_sof
EXEC GRLS.u_model_attribute @p_input_json,1,1

select * from GRLS.model_attribute where model_id=8

