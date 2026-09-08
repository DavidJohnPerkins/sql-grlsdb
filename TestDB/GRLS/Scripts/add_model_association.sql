USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"ABIGAILE_JOHNSON",
		"update_type":	"C",
		"model_associates": [
			{ "associate_sobriquet": "SHYLA_JENNINGS"}
		]
	}
'
EXEC GRLS.c_model_association @json, 0, 1

--select * from GRLS.model where sobriquet like 'AD%'

