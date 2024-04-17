USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS COMMON.paren
GO

CREATE FUNCTION COMMON.paren(@text varchar(255))
RETURNS varchar(255) AS  
BEGIN
	DECLARE @return_val varchar(255)

	SET @return_val = '(' + CONVERT(varchar, @text) + ')'

	RETURN @return_val
	
END
GO
