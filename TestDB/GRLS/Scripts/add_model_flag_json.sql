USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"ALEX_GREY",
		"update_type":	"C",
		"model_flags": [
			{ "flag_abbrev": "HTROPORN"},
			{ "flag_abbrev": "LSBNPORN"},
			{ "flag_abbrev": "EXCEPTNL"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1

--rollback TRANSACTION
--select * from GRLS.flag
