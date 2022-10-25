USE TestDB
GO

-- Script to build collection item deletion functionality

SET NOCOUNT ON
GO

PRINT 'EXECUTING SCRIPTS...'

:ON ERROR EXIT

SET NOCOUNT ON

-- Types
:r "TestDB/GRLS/Types/DataTypes/GRLS.image_url.sql"
:r "TestDB/COMMON/Types/TableTypes/COMMON.base_attrib_add_list_image.sql"
:r "TestDB/COMMON/Types/TableTypes/COMMON.image_model_add_list.sql"


-- Tables
:r "TestDB/GRLS/Tables/GRLS.model.sql"
:r "TestDB/GRLS/Tables/GRLS.image_attribute_level_1.sql"
:r "TestDB/GRLS/Tables/GRLS.image_attribute_level_2.sql"
:r "TestDB/GRLS/Tables/GRLS.image_attribute.sql"
:r "TestDB/GRLS/Tables/GRLS.image_model.sql"

-- Functions
:r "TestDB/GRLS/Functions/GRLS.image_attribute_values.sql"

-- StoredProcs
:r "TestDB/COMMON/StoredProcedures/COMMON.c_image.sql"
:r "TestDB/GRLS/StoredProcedures/GRLS.c_image_json.sql"

GO

PRINT 'SCRIPT COMPLETE'
GO
