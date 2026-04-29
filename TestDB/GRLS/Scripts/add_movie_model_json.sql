USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"ALTEA",
		"update_type":	"C",
		"movie_titles": [
			{ "movie_title": "antea.mp4"}
		]
	}
'
EXEC GRLS.c_model_movie_json @json, 1, 1


--select * from GRLS.movie where title like '%carr%' or title like '%ivy%'
--select * from GRLS.model where sobriquet like 'TIF%'
--exec GRLS.r_movie_list '{"model_id": -1, "minimum_rating": 1}'
--delete from GRLS.movie_model where id=1076

--select * from GRLS.model_name where model_name like '%cand%'
--select * from GRLS.model where id=1072
