-- =============================================
-- Author: INKYU PARK
-- Create date: 05-18-2017
-- Description:	Simple backup script
-- =============================================
USE s17guest30
GO
BACKUP DATABASE s17guest30
	TO DISK = '\s17guest30.bak'
		WITH FORMAT,
			MEDIANAME = 'MySQL_Backup_1',
			NAME = 'Backup of s17guest30';	
GO
