USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TYPE IF EXISTS GRLS.image_url
GO

CREATE TYPE GRLS.image_url
FROM nvarchar(1000) NOT NULL ;

GO