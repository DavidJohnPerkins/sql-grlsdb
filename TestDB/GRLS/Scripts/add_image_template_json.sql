USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"base_attribs": 
		{
			"image_url": 		"https://www.kindgirls.com/photo.php?pub=&nom=aria_45556&id=4807&num=16&pic=9&p=",
		 	"is_monochrome": 	0
		},
		"models": [
			{
				"sobriquet":	"ARIA_A"
			}
		],
		"attribs": [
			{
				"ia_abbrev": "LOCN", "options": [
					{ "ia_l2_desc": "Pool", 								"selected": 0 },
					{ "ia_l2_desc": "Beach", 								"selected": 1 },
					{ "ia_l2_desc": "Bed", 									"selected": 0 },
					{ "ia_l2_desc": "Bedroom", 								"selected": 0 },
					{ "ia_l2_desc": "Bathroom", 							"selected": 0 },
					{ "ia_l2_desc": "Bath", 								"selected": 0 },
					{ "ia_l2_desc": "Shower", 								"selected": 0 },
					{ "ia_l2_desc": "Lounge",								"selected": 0 },
					{ "ia_l2_desc": "Sofa", 								"selected": 0 },
					{ "ia_l2_desc": "Dining Room", 							"selected": 0 },
					{ "ia_l2_desc": "Countryside", 							"selected": 0 },
					{ "ia_l2_desc": "Urban", 								"selected": 0 },
					{ "ia_l2_desc": "Kitchen", 								"selected": 0 },
					{ "ia_l2_desc": "Garden", 								"selected": 0 },
					{ "ia_l2_desc": "Studio", 								"selected": 0 },
					{ "ia_l2_desc": "Massage Room", 						"selected": 0 },
					{ "ia_l2_desc": "Window", 								"selected": 0 },
					{ "ia_l2_desc": "Cropped - Not Relevant",				"selected": 0 }
				]
			},
			{
				"ia_abbrev": "DEXT", "options": [
					{ "ia_l2_desc": "Nude", 								"selected": 0 },
					{ "ia_l2_desc": "No Nudity \/ Cropped", 				"selected": 0 },
					{ "ia_l2_desc": "Breasts Only Visible", 				"selected": 1 },
					{ "ia_l2_desc": "Pubes Only Visible", 					"selected": 0 },
					{ "ia_l2_desc": "Arse Only Visible", 					"selected": 0 },
					{ "ia_l2_desc": "Breasts \/ Pubes \/ Arse Visible",		"selected": 0 },
					{ "ia_l2_desc": "Breasts \/ Pubes Visible", 			"selected": 0 },
					{ "ia_l2_desc": "Breasts \/ Arse Visible", 				"selected": 0 },
					{ "ia_l2_desc": "Pubes \/ Arse Visible", 				"selected": 0 }
				]
			},
			{
				"ia_abbrev": "DTYP", "options": [
					{ "ia_l2_desc": "None", 								"selected": 1 },
					{ "ia_l2_desc": "Swimwear", 							"selected": 0 },
					{ "ia_l2_desc": "Lingerie", 							"selected": 0 },
					{ "ia_l2_desc": "Underwear", 							"selected": 0 },
					{ "ia_l2_desc": "Dress", 								"selected": 0 },
					{ "ia_l2_desc": "Skirt", 								"selected": 0 },
					{ "ia_l2_desc": "Shirt", 								"selected": 0 },
					{ "ia_l2_desc": "Shoes Only", 							"selected": 0 },
					{ "ia_l2_desc": "Sportswear", 							"selected": 0 }
				]
			},
			{
				"ia_abbrev": "POSE", "options": [
					{ "ia_l2_desc": "Standing", 							"selected": 1 },
					{ "ia_l2_desc": "Kneeling", 							"selected": 0 },
					{ "ia_l2_desc": "All Fours", 							"selected": 0 },
					{ "ia_l2_desc": "All Fours with Arse Raised",			"selected": 0 },
					{ "ia_l2_desc": "Lying - On Back", 						"selected": 0 },
					{ "ia_l2_desc": "Lying - On Side", 						"selected": 0 },
					{ "ia_l2_desc": "Lying - On Front", 					"selected": 0 },
					{ "ia_l2_desc": "Sitting - Legs Apart", 				"selected": 0 },
					{ "ia_l2_desc": "Bending Over", 						"selected": 0 },
					{ "ia_l2_desc": "Crouching", 							"selected": 0 },
					{ "ia_l2_desc": "Cropped - Not Relevant", 				"selected": 0 },
					{ "ia_l2_desc": "In Vehicle \/ On Bicycle", 			"selected": 0 }
				]
			},
			{
				"ia_abbrev": "BUSH", "options": [
					{ "ia_l2_desc": "None", 								"selected": 0 },
					{ "ia_l2_desc": "Minimal", 								"selected": 0 },
					{ "ia_l2_desc": "Mons Covered", 						"selected": 0 },
					{ "ia_l2_desc": "Full", 								"selected": 0 },
					{ "ia_l2_desc": "Cropped - Not Relevant",				"selected": 1 }
				]
			},
			{
				"ia_abbrev": "ASPC", "options": [
					{ "ia_l2_desc": "Full Frontal", 						"selected": 1 },
					{ "ia_l2_desc": "Full from Rear", 						"selected": 0 },
					{ "ia_l2_desc": "Arse Centre", 							"selected": 0 },
					{ "ia_l2_desc": "Pubes Centre", 						"selected": 0 },
					{ "ia_l2_desc": "Breasts Centre", 						"selected": 0 },
					{ "ia_l2_desc": "Arse Centre", 							"selected": 0 },
					{ "ia_l2_desc": "Cropped - Not Relevant",				"selected": 0 }
				]
			},
			{
				"ia_abbrev": "CROP", "options": [
					{ "ia_l2_desc": "Full Figure", 							"selected": 0 },
					{ "ia_l2_desc": "Cropped Head", 						"selected": 0 },
					{ "ia_l2_desc": "Breasts", 								"selected": 0 },
					{ "ia_l2_desc": "Breasts Close-up", 					"selected": 0 },
					{ "ia_l2_desc": "Breasts Up", 							"selected": 1 },
					{ "ia_l2_desc": "Pubes", 								"selected": 0 },
					{ "ia_l2_desc": "Pubes Close-up", 						"selected": 0 },
					{ "ia_l2_desc": "Pubes \/ Arse Up",						"selected": 0 },
					{ "ia_l2_desc": "Pubes \/ Breasts", 					"selected": 0 },
					{ "ia_l2_desc": "Arse", 								"selected": 0 },
					{ "ia_l2_desc": "Arse Close-up", 						"selected": 0 },
					{ "ia_l2_desc": "Arse Up", 								"selected": 0 }
				]
			},
			{
				"ia_abbrev": "LEGS", "options": [
					{ "ia_l2_desc": "Not Shown", 							"selected": 1 },
					{ "ia_l2_desc": "Together", 							"selected": 0 },
					{ "ia_l2_desc": "Slightly Apart",						"selected": 0 },
					{ "ia_l2_desc": "Wide Apart", 							"selected": 0 }
				]
			},
			{
				"ia_abbrev": "TOUC", "options": [
					{ "ia_l2_desc": "None",									"selected": 1 },
					{ "ia_l2_desc": "Non-intimate",							"selected": 0 },
					{ "ia_l2_desc": "Breasts - Light", 						"selected": 0 },
					{ "ia_l2_desc": "Breasts - Heavy", 						"selected": 0 },
					{ "ia_l2_desc": "Pubes",								"selected": 0 },
					{ "ia_l2_desc": "Pubes with Penetration",				"selected": 0 },
					{ "ia_l2_desc": "Pubes with Object", 					"selected": 0 },
					{ "ia_l2_desc": "Arse",									"selected": 0 },
					{ "ia_l2_desc": "Arse with Penetration", 				"selected": 0 },
					{ "ia_l2_desc": "Arse with Object", 					"selected": 0 }
				]
			}
		]
	}
'

EXEC GRLS.c_image_json @json, 0, 1
