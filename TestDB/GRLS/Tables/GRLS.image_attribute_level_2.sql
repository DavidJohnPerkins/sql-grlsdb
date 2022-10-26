USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.image_attribute_level_2', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_ial2id_ial1id ON GRLS.image_attribute_level_2

	ALTER TABLE GRLS.image_attribute_level_2
	DROP CONSTRAINT FK_ia_l2_ia_l1

	DROP TABLE GRLS.image_attribute_level_2
	PRINT '########## Table GRLS.image_attribute_level_2 dropped successfully ##########'
END
GO

CREATE TABLE GRLS.image_attribute_level_2(
	ia_l2_id		int IDENTITY(1, 1) NOT NULL ,
	ia_l1_id		int NOT NULL ,
	ia_l2_desc		varchar(50) 
) ON [PRIMARY]
GO

ALTER TABLE GRLS.image_attribute_level_2 ADD PRIMARY KEY NONCLUSTERED 
(
	ia_l2_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

CREATE UNIQUE CLUSTERED INDEX U_IDX_ial2id_ial1id ON GRLS.image_attribute_level_2 (ia_l2_id, ia_l1_id) ON [PRIMARY];
GO

ALTER TABLE GRLS.image_attribute_level_2 ADD CONSTRAINT FK_ia_l2_ia_l1 FOREIGN KEY (ia_l1_id) REFERENCES GRLS.image_attribute_level_1(ia_l1_id)
		ON DELETE CASCADE;
GO
PRINT '########## Table GRLS.image_attribute_level_2 created successfully ##########'
