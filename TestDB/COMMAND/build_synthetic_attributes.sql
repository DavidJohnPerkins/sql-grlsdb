USE TestDB
GO

-- Script to build collection item deletion functionality

SET NOCOUNT ON
GO

PRINT 'EXECUTING SCRIPTS...'

:ON ERROR EXIT

SET NOCOUNT ON

DROP PROCEDURE IF EXISTS COMMON.c_model
GO

-- Tables
:r "TestDB/GRLS/Tables/GRLS.model.sql"

-- Types
:r "TestDB/COMMON/Types/TableTypes/COMMON.base_attrib_add_list.sql"
:r "TestDB/COMMON/Types/TableTypes/COMMON.attrib_add_list.sql"
:r "TestDB/COMMON/Types/TableTypes/COMMON.name_add_list.sql"

-- Views
:r "TestDB/GRLS/Views/GRLS.v_basic_analysis.sql"
:r "TestDB/GRLS/Views/GRLS.v_attribute_level_2_detail.sql"
:r "TestDB/GRLS/Views/GRLS.v_attribute.sql"

-- StoredProcs
:r "TestDB/COMMON/StoredProcedures/COMMON.c_model.sql"
:r "TestDB/GRLS/StoredProcedures/GRLS.c_model_json.sql"
:r "TestDB/GRLS/StoredProcedures/GRLS.update_model_attribute.sql"

GO

PRINT 'SCRIPT COMPLETE'
GO
