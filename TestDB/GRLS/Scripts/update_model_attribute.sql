declare @json COMMON.json = '
	{
		"model_sobriquet": "EKATERINA_D",
		"l1_abbrev": "MONS",
		"l2_desc": "Narrow / Retreating"
	}
'

EXEC GRLS.update_model_attribute @json
