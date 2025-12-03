USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"MICHELLE_H",
		"update_type":	"C",
		"model_flags": [
			{ "flag_abbrev": "HTROPORN"}
		]
	}
'
EXEC GRLS.c_model_flag_json @json, 0, 1

--rollback TRANSACTION
--select * from GRLS.flag
