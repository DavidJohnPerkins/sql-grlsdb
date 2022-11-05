declare @json COMMON.json = '
	{
		"model_sobriquet": "ARIA_A",
		"l1_abbrev": "NPPF",
		"l2_desc": "Very Puffy"
	}
'

EXEC GRLS.update_model_attribute @json,0,1
