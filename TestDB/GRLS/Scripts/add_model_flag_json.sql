USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"ANNA_TATU",
		"update_type":	"C",
		"model_flags": [
			{ "flag_abbrev": "EXCEPTNL"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1
