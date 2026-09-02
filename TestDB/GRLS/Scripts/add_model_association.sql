USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"CLOVER",
		"update_type":	"C",
		"model_associates": [
			{ "associate_sobriquet": "GRACE"}
		]
	}
'
EXEC GRLS.c_model_association @json, 0, 1

--select * from GRLS.model where sobriquet like 'SY%'

