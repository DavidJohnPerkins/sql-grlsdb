USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"NENSI_B",
		"update_type":	"C",
		"movie_titles": [
			{ "movie_title": "whitney-medina.mp4"},
			{ "movie_title": "foxy-di.mp4"},
			{ "movie_title": "kate-keira-teal.mp4"}

		]
	}
'
EXEC GRLS.c_model_movie_json @json, 1, 1
