declare @json COMMON.json = '
	{
		"model_sobriquet": "AIDA",
		"l1_abbrev": "PUAT",
		"l2_desc": "Plump No Protrusion"
	}
'

EXEC GRLS.update_model_attribute @json,0,1
