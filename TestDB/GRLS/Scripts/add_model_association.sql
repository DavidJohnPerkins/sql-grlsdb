USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"MICHELLE_H",
		"update_type":	"C",
		"model_associates": [
			{ "associate_sobriquet": "IZZY_DELPHINE"}
		]
	}
'
EXEC GRLS.c_model_association @json, 1, 1

select * from GRLS.model_associate
