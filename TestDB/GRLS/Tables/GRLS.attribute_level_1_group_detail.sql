USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.attribute_level_1_group_detail', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_l1group_l1id ON GRLS.attribute_level_1_group_detail

	ALTER TABLE GRLS.attribute_level_1_group_detail
	DROP CONSTRAINT FK_l1_group_id_l1_group

	ALTER TABLE GRLS.attribute_level_1_group_detail
	DROP CONSTRAINT FK_l1_id_attribute_level_1

	DROP TABLE GRLS.attribute_level_1_group_detail
	PRINT '########## Table GRLS.attribute_level_1_group_detail dropped successfully ##########'
END
GO

CREATE TABLE GRLS.attribute_level_1_group_detail(
	l1_group_detail_id	int IDENTITY(1, 1) NOT NULL,
	l1_group_id 		int NOT NULL,
	l1_id 				int NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE GRLS.attribute_level_1_group_detail ADD PRIMARY KEY NONCLUSTERED 
(
	l1_group_detail_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX U_IDX_l1group_l1id ON GRLS.attribute_level_1_group_detail (l1_group_id, l1_id) ON [PRIMARY];
GO

ALTER TABLE GRLS.attribute_level_1_group_detail ADD CONSTRAINT FK_l1_group_id_l1_group FOREIGN KEY (l1_group_id) REFERENCES GRLS.attribute_level_1_group(l1_group_id) ON DELETE CASCADE;
GO

ALTER TABLE GRLS.attribute_level_1_group_detail ADD CONSTRAINT FK_l1_id_attribute_level_1 FOREIGN KEY (l1_id) REFERENCES GRLS.attribute_level_1(l1_id) ON DELETE CASCADE;
GO

PRINT '########## Table GRLS.attribute_level_1_group_detail created successfully ##########'
