SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: INKYU PARK
-- Create date: MAY 18 2017
-- Description:	This procedure insert speaker and presentation
--                      
-- =============================================
-- 
ALTER PROC insertPresentation(@speaker AS NVARCHAR(200), @presentation AS VARCHAR(400))
AS
BEGIN

	-- if @speaker not exist we add speaker to people table,
	-- add presentation with last inserted person_id

	IF NOT EXISTS(	
		SELECT
			firstname,
			lastname
		FROM
			People
		WHERE
			firstname = left(@speaker, CHARINDEX(' ', @speaker))
			AND lastname = substring(@speaker, CHARINDEX(' ', @speaker)+1, len(@speaker)-(CHARINDEX(' ', @speaker)-1))
	)
	BEGIN
		INSERT INTO People (firstName, lastName) VALUES (
			left(@speaker, CHARINDEX(' ', @speaker)), 
			substring(@speaker, CHARINDEX(' ', @speaker)+1, len(@speaker)-(CHARINDEX(' ', @speaker)-1))
		)		
		INSERT INTO Presenter (person_id) VALUES (IDENT_CURRENT('People'))
		INSERT INTO Presentation (title, person_id) VALUES (@presentation, IDENT_CURRENT('People'))
	END

	-- if @speaker exist we need to get the person_id of speaker,
	-- add presentation with present person id

	IF EXISTS(	
		SELECT
			firstname,
			lastname
		FROM
			People
		WHERE
			firstname = left(@speaker, CHARINDEX(' ', @speaker))
			AND lastname = substring(@speaker, CHARINDEX(' ', @speaker)+1, len(@speaker)-(CHARINDEX(' ', @speaker)-1))
	)
	BEGIN
		INSERT INTO Presentation (title, person_id) VALUES (@presentation, (
			SELECT person_id FROM People 
			WHERE 
				firstname = left(@speaker, CHARINDEX(' ', @speaker))
				AND lastname = substring(@speaker, CHARINDEX(' ', @speaker)+1, len(@speaker)-(CHARINDEX(' ', @speaker)-1))
		))
	END
END