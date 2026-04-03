declare @json nvarchar(MAX) = '
    {
        "model_id": -1,
        "title_search_term": "",
        "comment_search_term": "%rim%",
        "minimum_rating": 1
    }
'
exec GRLS.r_movie_list @json, 1, 1

