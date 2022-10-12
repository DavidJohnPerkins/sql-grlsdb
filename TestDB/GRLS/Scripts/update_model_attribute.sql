declare @json COMMON.json = '
	{
		"model_sobriquet": "NORDICA",
		"l1_abbrev": "ASHP",
		"l2_desc": "Boyish"
	}
'

EXEC GRLS.update_model_attribute @json
