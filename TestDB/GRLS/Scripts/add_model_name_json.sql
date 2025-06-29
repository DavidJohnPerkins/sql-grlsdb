USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"MICHELLE_H",
		"update_type":	"C",
		"model_names": [
			{ "model_name":	"Marga E", "is_principal_name": 0 },
			{ "model_name":	"Noemi", "is_principal_name": 0 },
			{ "model_name":	"Red Fox", "is_principal_name": 0 }
		],
	}
'
EXEC GRLS.c_model_name_json @json, 0, 1

--rollback TRANSACTION
--select * from GRLS.flag
