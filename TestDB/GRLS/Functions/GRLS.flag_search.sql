USE TestDB;  
GO  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('GRLS.flag_search', 'TF') IS NOT NULL  
	DROP FUNCTION GRLS.flag_search
	PRINT '########## GRLS.flag_search dropped successfully ##########'
GO  

CREATE FUNCTION GRLS.flag_search(@p_input_json COMMON.json, @flagsum GRLS.kv_pair_int READONLY)
RETURNS 
@result TABLE (
	object_id int
)
AS 
BEGIN 
	DECLARE @mode		char(3) = JSON_VALUE(@p_input_json, '$."search_mode_flag"'),
			@flag_type	char(3) = JSON_VALUE(@p_input_json, '$."flag_type"');

	WITH w_flags AS (
		SELECT
			f.flag_abbrev	AS flag_abbrev,
			f.selected		AS bit
		FROM 
			OPENJSON (@p_input_json, '$.search_flags')
			WITH
			(
				flag_abbrev	char(8),
				selected	bit
			) f
		WHERE
			f.selected = 1
	), --select * from w_flags,
	w_searchsum AS (
		SELECT 
			SUM(fb.bin_val) AS srchsum
		FROM 
			GRLS.bv_flag_binary fb
			INNER JOIN GRLS.flag f
				INNER JOIN GRLS.flag_type ft
				ON f.flag_type = ft.id
				INNER JOIN w_flags i
				ON f.flag_abbrev = i.flag_abbrev
			ON fb.flag_abbrev = f.flag_abbrev
		WHERE
			ft.flag_type_abbrev = @flag_type AND 
			fb.flag_type_abbrev = @flag_type
	) --select * from w_searchsum
	INSERT @result 
	SELECT 
		fs.key_value
	FROM 
		w_searchsum w,
		@flagsum fs
		--LEFT OUTER JOIN @flagsum fs
		--ON m.id = fs.key_value
	WHERE 
		((fs.data_value & w.srchsum != 0 AND @mode = 'ANY') OR 
		(fs.data_value & w.srchsum = w.srchsum AND @mode = 'ALL')) OR 
		w.srchsum IS NULL

	RETURN

END
GO
PRINT '########## GRLS.flag_search dropped successfully ##########'


