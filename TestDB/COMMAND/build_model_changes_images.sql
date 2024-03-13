USE TestDB
GO

-- Script to build collection item deletion functionality

SET NOCOUNT ON
GO

PRINT 'EXECUTING SCRIPTS...'

:ON ERROR EXIT

-- Types
--:r "TestDB/GRLS/Types/DataTypes/COMMON.image_url.sql"
:r "TestDB/COMMON/Types/TableTypes/COMMON.base_attrib_add_list_image.sql"
:r "TestDB/COMMON/Types/TableTypes/COMMON.image_model_add_list.sql"


-- Tables
:r "TestDB/GRLS/Tables/GRLS.model.sql"
:r "TestDB/GRLS/Tables/GRLS.image.sql"
:r "TestDB/GRLS/Tables/GRLS.image_attribute_level_1.sql"
:r "TestDB/GRLS/Tables/GRLS.image_attribute_level_2.sql"
:r "TestDB/GRLS/Tables/GRLS.image_attribute.sql"
:r "TestDB/GRLS/Tables/GRLS.image_model.sql"

-- Functions
:r "TestDB/GRLS/Functions/GRLS.image_attribute_values.sql"

-- StoredProcs
:r "TestDB/COMMON/StoredProcedures/COMMON.c_image.sql"
:r "TestDB/GRLS/StoredProcedures/GRLS.c_image_json.sql"
:r "TestDB/GRLS/StoredProcedures/GRLS.add_level_2_model_attribute.sql"

-- Scripts
:r "TestDB/GRLS/Scripts/populate_yob.sql"
:r "TestDB/GRLS/Scripts/image_metadata.sql"

PRINT 'SCRIPT COMPLETE'
