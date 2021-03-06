USE [s17guest30]
GO
/****** Object:  StoredProcedure [dbo].[budapestTrackPresentations]    Script Date: 5/18/2017 12:07:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Inkyu Park
-- Create date: 05-18-2017
-- Description: find the presentations with given track, 
-- if track parameter is null we use default value which is 4
-- usage EXEC [dbo].[budapestTrackPresentations] <track_number>(optional)
-- =============================================
ALTER PROC [dbo].[budapestTrackPresentations] (@track as INT = 4)
AS
BEGIN TRY
	SELECT Schedule.track_id, Presentation.title, Event_Location.city
	FROM Schedule
	INNER JOIN Presentation ON Schedule.presentation_id = Presentation.presentation_id
	INNER JOIN Event_Location ON Presentation.event_loc_id = Event_Location.event_loc_id
	WHERE Schedule.track_id = @track
	AND Event_Location.city = 'Budapest'	
END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;
	SELECT
	@ErrorMessage = ERROR_MESSAGE(),
	@ErrorSeverity = ERROR_SEVERITY(),
	@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH