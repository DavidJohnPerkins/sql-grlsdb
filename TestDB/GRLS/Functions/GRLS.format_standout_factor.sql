USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.format_standout_factor') AND [type] IN ('FN'))
BEGIN 
	DROP FUNCTION GRLS.format_standout_factor
	PRINT '########## GRLS.format_standout_factor dropped successfully ##########'
END
GO

CREATE FUNCTION GRLS.format_standout_factor(@factor float)
RETURNS varchar(10) AS  
BEGIN
	DECLARE @return_val varchar(10) = ''

	IF @factor != 1
	BEGIN
		SET @return_val = ' * ' + CONVERT(varchar(10), @factor)
	END
	RETURN @return_val
	
END
GO
PRINT '########## GRLS.format_standout_factor created successfully ##########'
