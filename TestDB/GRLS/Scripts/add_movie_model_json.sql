USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"KATHERINE_A",
		"update_type":	"C",
		"movie_titles": [
			{ "movie_title": "abbi.mp4"}
		]
	}
'
EXEC GRLS.c_model_movie_json @json, 1, 1
