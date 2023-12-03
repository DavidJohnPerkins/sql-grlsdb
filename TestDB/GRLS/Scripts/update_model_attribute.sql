DECLARE	@sobr	GRLS.sobriquet = 'KIMIKO',
		@abbrev	GRLS.l1_abbrev = 'ATTR'

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

declare @json COMMON.json = '[
	{
		"model_sobriquet": "KIMIKO",
		"l1_abbrev": "ATTR",
		"l2_desc": "Ten",
		"standout_factor": 1.2
	}
]
'

EXEC GRLS.update_model_attribute @json,1,1

