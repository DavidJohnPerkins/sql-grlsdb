USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TYPE IF EXISTS GRLS.generic_list_vc_int
GO

CREATE TYPE GRLS.generic_list_vc_int AS TABLE   
(
	data_value_vc	varchar(50) ,
	data_value_int	int
)
GO  