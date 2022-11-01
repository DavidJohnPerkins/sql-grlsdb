declare @json COMMON.json = '
	{
		"model_sobriquet": "ZELDA",
		"l1_abbrev": "BRSH",
		"l2_desc": "Semi-Pendulous"
	}
'

EXEC GRLS.update_model_attribute @json,0,1
