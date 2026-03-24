USE TestDB
GO

			--{ "flag_abbrev": "ANLINGUS"}
			--{ "flag_abbrev": "CNLINGUS"}
			--{ "flag_abbrev": "MASTBATE"}
			--{ "flag_abbrev": "PENETRTE"}
			--{ "flag_abbrev": "TOYSOBJS"}
			--{ "flag_abbrev": "EXCEPTNL"}
			--{ "flag_abbrev": "SHWRBATH"}
			--{ "flag_abbrev": "SWIMPOOL"}

DECLARE @json	COMMON.json = '
	{
		"movie_id":	24,
		"update_type":	"C",
		"model_flags": [
			{ "flag_abbrev": "CNLINGUS"},
			{ "flag_abbrev": "EXCEPTNL"}
		]
	}
'
EXEC GRLS.c_movie_flag_json @json, 0, 1

--