USE [TestDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TYPE IF EXISTS GRLS.kv_pair
GO

CREATE TYPE GRLS.kv_pair AS TABLE   
(
	key_value			varchar(50) ,
	data_value			varchar(50)
)
GO  