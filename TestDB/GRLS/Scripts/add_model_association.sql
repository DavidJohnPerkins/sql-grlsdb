USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"LADY_D",
		"update_type":	"C",
		"model_associates": [
			{ "associate_sobriquet": "LUCY_LI"},
			{ "associate_sobriquet": "JIA_LISSA"}
		]
	}
'
EXEC GRLS.c_model_association @json, 0, 1

--select * from GRLS.model where sobriquet like 'SY%'

