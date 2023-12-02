declare @json COMMON.json = '
	{
		"model_sobriquet": "VESELIN",
		"l1_abbrev": "MONS",
		"l2_desc": "Natural \/ Retreating"
	}
'

EXEC GRLS.update_model_attribute @json,1,1

