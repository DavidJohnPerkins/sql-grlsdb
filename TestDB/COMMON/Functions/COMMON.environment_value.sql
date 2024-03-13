USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.environment_value') AND [type] IN ('FN'))
BEGIN 
	DROP FUNCTION COMMON.environment_value
	PRINT '########## COMMON.environment_value dropped successfully ##########'
END
GO

CREATE FUNCTION COMMON.environment_value(@variable varchar(50), @default varchar(50))
RETURNS varchar(50) AS  
BEGIN
	DECLARE @return_val varchar(50) = @default

	SET @return_val = (
		SELECT
			ISNULL(NULLIF(MAX(e.env_value), ''), @default) 
		FROM 
			COMMON.environment e
		WHERE
			e.env_var = @variable
	)

	RETURN @return_val
	
END
GO
PRINT '########## COMMON.environment_value created successfully ##########'
