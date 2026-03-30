USE [TestDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TYPE IF EXISTS GRLS.kv_pair_int
GO

CREATE TYPE GRLS.kv_pair_int AS TABLE   
(
	key_value	int,
	data_value	int
)
GO  