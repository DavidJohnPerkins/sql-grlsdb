USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TYPE IF EXISTS COMMON.image_url
GO

CREATE TYPE COMMON.image_url
FROM nvarchar(400) NOT NULL ;

GO
