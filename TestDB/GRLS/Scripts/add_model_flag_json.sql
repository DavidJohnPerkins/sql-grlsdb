USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"NIKA_O",
		"update_type":	"add",
		"model_flags": [
			{ "flag_abbrev": "WMNCHILD"},
			{ "flag_abbrev": "EXCEPTNL"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1

--rollback TRANSACTION
--select * from GRLS.flag
