USE TestDB
GO

DROP TYPE IF EXISTS COMMON.json
GO

CREATE TYPE COMMON.json
FROM nvarchar(MAX) NOT NULL