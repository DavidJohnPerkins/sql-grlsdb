USE TestDB
GO

DECLARE @attribs_json COMMON.json = '
	{
		"l1_abbrev": 	"PUAT",
		"l2_desc":		"Plump Slight Protrusion",
		"preferences": [
			{
				"scheme_id": 1,
				"l2_preference": 16
			},
			{
				"scheme_id": 2,
				"l2_preference": 12
			},
			{
				"scheme_id": 3,
				"l2_preference": 16
			}
		]
	}
'
EXEC GRLS.add_level_2_model_attribute @attribs_json, 0,1

--select * from GRLS.v_attribute_level_2_detail where abbrev='PUAT' order by abbrev,l2_desc
commit