USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"CANDICE",
		"update_type":	"C",
		"model_names": [
			{ "model_name":	"Kaylee", "is_principal_name": 0 }
		],
	}
'
EXEC GRLS.c_model_name_json @json, 0, 1
