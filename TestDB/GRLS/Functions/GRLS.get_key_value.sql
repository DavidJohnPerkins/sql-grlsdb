USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS GRLS.get_key_value
GO

CREATE FUNCTION GRLS.get_key_value(@attrib_list GRLS.kv_pair READONLY, @search_key varchar(50))
RETURNS nvarchar(MAX) AS  
BEGIN
	DECLARE @return_val nvarchar(MAX)

	SET @return_val = (
		SELECT
			a.data_value
		FROM 
			@attrib_list a
		WHERE
			a.key_value = @search_key
	)

	RETURN @return_val
	
END
GO
