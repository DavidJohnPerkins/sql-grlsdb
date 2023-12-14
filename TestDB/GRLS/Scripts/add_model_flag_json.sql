USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":		"NENSI_B",
		"model_flags": [
			{ "flag_abbrev": "WMNCHILD"}
		],
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1

