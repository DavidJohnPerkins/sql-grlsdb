USE TestDB
GO

DECLARE @attribs_json COMMON.json = '
	{
		"l1_abbrev": 	"BRSH",
		"l2_desc":		"Semi-Pendulous Globe",
		"preferences": [
			{
				"scheme_id": 1,
				"l2_preference": 12
			},
			{
				"scheme_id": 2,
				"l2_preference": 12
			},
			{
				"scheme_id": 3,
				"l2_preference": 12
			}
		]
	}
'
EXEC GRLS.add_level_2_model_attribute @attribs_json, 0,1

--select * from GRLS.v_attribute_level_2_detail where abbrev='PUAT' order by abbrev,l2_desc
