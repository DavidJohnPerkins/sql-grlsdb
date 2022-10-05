-- Script to build collection item deletion functionality

SET NOCOUNT ON
GO

PRINT 'EXECUTING SCRIPTS...'

:ON ERROR EXIT

USE Collections
GO

SET NOCOUNT ON

:r "TestDB/GRLS/Views/GRLS.v_basic_analysis.sql"
:r "TestDB/GRLS/Views/GRLS.v_analysis_pivot.sql"
GO

PRINT 'SCRIPT COMPLETE'
GO
