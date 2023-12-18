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

declare @json COMMON.json = '[
	{
		"model_sobriquet": "ALICE_MAY",
		"l1_abbrev": "NPPF",
		"l2_desc": "Slightly Puffy",
		"standout_factor": 1.1
	}
]
'
EXEC GRLS.u_model_attribute @json,1,1
