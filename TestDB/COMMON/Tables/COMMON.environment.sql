USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('COMMON.environment', 'U') IS NOT NULL
BEGIN
	DROP TABLE COMMON.environment

END
GO
CREATE TABLE COMMON.environment (
	env_var		varchar(20) PRIMARY KEY NOT NULL,
	env_value	varchar(20) NOT NULL
)
GO
