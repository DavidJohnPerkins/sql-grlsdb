DECLARE @attribs_json COMMON.json = '
	{
		"l1_abbrev": 	"ASHP",
		"l2_desc":		"Rounded",
		"preferences": [
			{
				"scheme_id": 1,
				"l2_preference": 1
			},
			{
				"scheme_id": 2,
				"l2_preference": 1
			},
			{
				"scheme_id": 3,
				"l2_preference": 1
			},
			{
				"scheme_id": 1002,
				"l2_preference": 1
			},
			{
				"scheme_id": 1009,
				"l2_preference": 1
			}
		]
	}
'
EXEC GRLS.add_level_2_model_attribute @attribs_json, 0,1
