USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"LUCY_LI",
		"update_type":	"C",
		"model_flags": [
			{ "flag_abbrev": "LRGBRSTS"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1
