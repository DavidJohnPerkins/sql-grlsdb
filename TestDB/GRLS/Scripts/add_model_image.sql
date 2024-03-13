USE TestDB
GO

DECLARE @images_json	COMMON.json = '
	{
		"sobriquet":	"ASPEN_A",
		"update_type":	"C",
		"images": [
			{
				"image_url":	"https://www.kindgirls.com/girlsp/aspen-a.jpg",
				"image_type_abbrev":	"TH"
			},
			{
				"image_url":	"https://gals.kindgirls.com/d009/aspen_23646/aspen_23646_4.jpg",
				"image_type_abbrev":	"RF"
			},
			{
				"image_url":	"https://gals.kindgirls.com/d009/aspen_23646/aspen_23646_3.jpg",
				"image_type_abbrev":	"FA"
			},
			{
				"image_url":	"https://gals.kindgirls.com/d009/aspen_23646/aspen_23646_13.jpg",
				"image_type_abbrev":	"BR"
			},
			{
				"image_url":	"https://gals.kindgirls.com/d009/aspen_23646/aspen_23646_14.jpg",
				"image_type_abbrev":	"PF"
			},
			{
				"image_url":	"https://gals.kindgirls.com/d009/aspen_52690/aspen_52690_11.jpg",
				"image_type_abbrev":	"PR"
			},
			{
				"image_url":	"https://gals.kindgirls.com/d009/aspen_52690/aspen_52690_13.jpg",
				"image_type_abbrev":	"AR"
			}
		]
	}
'

EXEC GRLS.c_model_image_web_json @images_json, 0, 1
