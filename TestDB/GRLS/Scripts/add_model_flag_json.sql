USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"BREA",
		"update_type":	"add",
		"model_flags": [
			{ "flag_abbrev": "LSBNPORN"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1

--rollback TRANSACTION
--select * from GRLS.flag
