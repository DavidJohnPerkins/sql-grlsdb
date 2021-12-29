USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS COMMON.sq
GO

CREATE FUNCTION COMMON.sq(@text varchar(255))
RETURNS varchar(255) AS  
BEGIN
	DECLARE @return_val varchar(255)

	SET @return_val = '''' + @text + ''''

	RETURN @return_val
	
END
GO
