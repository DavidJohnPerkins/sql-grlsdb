USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"SONYA_BLAZE",
		"update_type":	"C",
		"model_flags": [
			{ "flag_abbrev": "HTROPORN"},
			{ "flag_abbrev": "LSBNPORN"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1
