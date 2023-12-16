USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"KATIE_A",
		"update_type":	"add",
		"model_flags": [
			{ "flag_abbrev": "WMNCHILD"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1

--rollback TRANSACTION
