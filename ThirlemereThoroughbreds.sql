-- ================================================================= --
-- Date: 18 February 2021
-- Author: Kyra E Alday
-- Topic: Databases (Week 3)
-- Description: SQL Database for Thirlemere Thoroughbreds
-- ================================================================= --

-- ================================================================= --
-- Create Database: Thirlemere Thoroughbreds
-- ================================================================= --

USE master -- connect to the MASTER database
GO

-- check if database exists - delete if does (DROP)
IF EXISTS(  SELECT *
            FROM master..sysdatabases
            WHERE name = 'ThirlemereThoroughbreds'
	     )
DROP DATABASE ThirlemereThoroughbreds;
GO

CREATE DATABASE ThirlemereThoroughbreds;
GO

-- connect ThirlemereThoroughbreds database
USE ThirlemereThoroughbreds; 
GO

-- HORSE TABLE
CREATE TABLE HORSE(
    horse_id        NCHAR(3),
    horse_name      NVARCHAR(15) NULL,
    colour          NVARCHAR(8) NULL,
    sire            NCHAR(3) NULL,
    dam             NCHAR(3) NULL,
    born            SMALLINT NULL,
    died            SMALLINT NULL,
    gender          NCHAR(1)

CONSTRAINT horse_PK PRIMARY KEY (horse_id)
);
GO


-- ENTRY TABLE
CREATE TABLE [ENTRY] (
    event_id        NCHAR(4),
    horse_id        NCHAR(3),
    place           TINYINT NULL

CONSTRAINT entry_PK PRIMARY KEY (event_id, horse_id)
);
GO

-- JUDGE TABLE
CREATE TABLE JUDGE(
    judge_id        NCHAR(2),
    judge_name      NVARCHAR(15),
    address         NVARCHAR(30)

CONSTRAINT judge_PK PRIMARY KEY (judge_id)
);
GO

-- EVENT TABLE
CREATE TABLE [EVENT] (
    event_id        NCHAR(4),
    show_id         NCHAR(2),
    event_name      NVARCHAR(15),
    judge_id        NCHAR(2)

CONSTRAINT event_PK PRIMARY KEY (event_id)
);
GO

-- PRIZE TABLE
CREATE TABLE PRIZE(
    event_code      NCHAR(4),
    place           TINYINT,
    prizemoney      MONEY

CONSTRAINT prize_PK PRIMARY KEY (event_code, place)
);
GO

-- SHOW TABLE
CREATE TABLE SHOW(
    show_id         NCHAR(2),
    show_name       NVARCHAR(15) NULL,
    show_held       DATETIME NULL,
    show_address    NVARCHAR(30)

CONSTRAINT show_PK PRIMARY KEY (show_id)
);
GO


-- ================================================================= --
-- Insert Test Data
-- ================================================================= --

USE ThirlemereThoroughbreds
GO
SET DATEFORMAT dmy;
GO
-- Table 'horse'
INSERT INTO horse VALUES ('502', 'Sally','white', NULL, NULL,1974,1987,'M')
INSERT INTO horse VALUES ('501','Bluebell','grey', NULL, NULL,1975,1982,'M')
INSERT INTO horse VALUES ('401','Snowy','white', NULL, NULL,1976,1984,'S')
INSERT INTO horse VALUES ('302','Tinkle','brown','401','501',1981,1994,'M')
INSERT INTO horse VALUES ('301','Daisy','white','401','502',1981,NULL,'M')
INSERT INTO horse VALUES ('201','Boxer','grey ','401','501',1980,NULL,'S')
INSERT INTO horse VALUES ('102','Star','brown','201','302',1991,NULL,'M')
INSERT INTO horse VALUES ('101','Flash','white','201','301',1990,NULL,'S')
-- Table 'show' 
INSERT INTO show VALUES ('01', 'Dubbo', '05/07/1995', '23 Wingewarra St, Dubbo')
INSERT INTO show VALUES ('02', 'Young', '13/09/1995', '13 Cherry Lane, Young')
INSERT INTO show VALUES ('03', 'Castle Hill', '04/05/1996', 'Showground Rd, Castle Hill')
INSERT INTO show VALUES ('04', 'Royal Easter', '21/04/1996', 'PO Box 13, GPO Sydney')
INSERT INTO show VALUES ('05', 'Dubbo', '01/07/1996', '17 Fitzroy St, Dubbo')
-- Table 'judge'
INSERT INTO judge VALUES ('01', 'Smith', 'Melbourne')
INSERT INTO judge VALUES ('02', 'Green', 'Cootamundra')
INSERT INTO judge VALUES ('03', 'Gates', 'Dunkeld')
INSERT INTO judge VALUES ('04', 'Smith', 'Sydney')
-- Table 'event'
INSERT INTO event VALUES ('0101', '01', 'Dressage', '01')
INSERT INTO event VALUES ('0102', '01', 'Jumping', '02')
INSERT INTO event VALUES ('0103', '01', 'Led in', '01')
INSERT INTO event VALUES ('0201', '02', 'Led in', '02')
INSERT INTO event VALUES ('0301', '03', 'Led in', '01')
INSERT INTO event VALUES ('0401', '04', 'Dressage', '04')
INSERT INTO event VALUES ('0501', '05', 'Dressage', '01')
INSERT INTO event VALUES ('0502', '05', 'Flag and Pole', '02')
-- Table 'prize'
INSERT INTO prize VALUES ('0101', 1, 120)
INSERT INTO prize VALUES ('0101', 2, 60)
INSERT INTO prize VALUES ('0101', 3, 30)
INSERT INTO prize VALUES ('0102', 1, 10)
INSERT INTO prize VALUES ('0102', 2, 5)
INSERT INTO prize VALUES ('0103', 1, 100)
INSERT INTO prize VALUES ('0103', 2, 60)
INSERT INTO prize VALUES ('0103', 3, 40)
INSERT INTO prize VALUES ('0201', 1, 10)
INSERT INTO prize VALUES ('0201', 2, 5)
INSERT INTO prize VALUES ('0401', 1, 1000)
INSERT INTO prize VALUES ('0401', 2, 500)
INSERT INTO prize VALUES ('0401', 3, 250)
INSERT INTO prize VALUES ('0501', 1, 10)
INSERT INTO prize VALUES ('0501', 2, 5)
-- Table 'entry'
INSERT INTO entry VALUES ('0101', '101', 1)
INSERT INTO entry VALUES ('0101', '102', 2)
INSERT INTO entry VALUES ('0101', '201', 3)
INSERT INTO entry VALUES ('0101', '301', 4)
INSERT INTO entry VALUES ('0102', '201', 2)
INSERT INTO entry VALUES ('0103', '102', 3)
INSERT INTO entry VALUES ('0201', '101', 1)
INSERT INTO entry VALUES ('0301', '301', 2)
INSERT INTO entry VALUES ('0401', '102', 7)
INSERT INTO entry VALUES ('0501', '102', 1)
INSERT INTO entry VALUES ('0501', '301', 3)
GO


-- ================================================================= --
-- Add Foreign Keys
-- ================================================================= --

-- HORSE Table
ALTER TABLE HORSE ADD CONSTRAINT horse_sire_FK FOREIGN KEY (sire) REFERENCES HORSE;
ALTER TABLE HORSE ADD CONSTRAINT horse_dam_FK FOREIGN KEY (dam) REFERENCES HORSE;
GO

-- ENTRY Table
ALTER TABLE [ENTRY] ADD CONSTRAINT entry_event_FK FOREIGN KEY (event_id) REFERENCES [EVENT];
ALTER TABLE [ENTRY] ADD CONSTRAINT entry_horse_FK FOREIGN KEY (horse_id) REFERENCES HORSE;
GO

-- EVENT Table
ALTER TABLE [EVENT] ADD CONSTRAINT event_show_FK FOREIGN KEY (show_id) REFERENCES SHOW;
ALTER TABLE [EVENT] ADD CONSTRAINT event_judge_FK FOREIGN KEY (judge_id) REFERENCES JUDGE;
GO

-- PRIZE Table
ALTER TABLE PRIZE ADD CONSTRAINT prize_event_FK FOREIGN KEY (event_code) REFERENCES [EVENT];
GO


-- =============================================
-- SQL Section 1 - Problem Solutions
-- =============================================

USE [ThirlemereThoroughbreds]
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P01]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P01: Name and Address of Each Show
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P01]
	-- stored procedure parameters
	@p1 int = 0, 
	@p2 int = 0
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.1 List the name and address of each show
	SELECT	show_name,
			show_address
	FROM	SHOW

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P02]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 03/03/2021
-- Description:	SQL Section 1 - Problem Solutions
-- =============================================
CREATE PROCEDURE [dbo].[usp_S1P02] 
	-- Add the parameters for the stored procedure here
	-- Parameters that the stored procedure will use are defined at this location
	-- ALL parameter names are prefixed with the '@' character
	-- Syntax @parameterName DATATYPE = Default Value (Default Value is the value to be used by the query IF the user does not provide a value).
	@YrBrn SMALLINT = 1990
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 1.2 List the name of each horse that was born in 1990
	SELECT	horse_name		-- SELECT clause defines the columns to list
	FROM	HORSE			-- the FROM clause defines the tables to get them from
	WHERE	born = @YrBrn

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P03]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P03: Name and Address of Each Show with 13
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P03]
	-- stored procedure parameters
	@SrchChrs	NVARCHAR(30) = '13'
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.3  List the name and address of each show that has '13' as part of its address
	SELECT	show_name, 
			show_address
	FROM	SHOW
	WHERE	show_address LIKE '%' + @SrchChrs + '%';

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P04]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P04: Name, Birth, Color for Gray or White Mares
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P04]
	-- stored procedure parameters
	@Gender	NCHAR(1) = 'M',
	@Colr1	NVARCHAR(8) = 'Grey',
	@Colr2	NVARCHAR(8) = 'White'
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.4  List the name, year of birth and colour for each mare (mares have gender of ‘M’) that is either grey or white
	SELECT	horse_name,
			born,
			colour
	FROM	HORSE
	WHERE	gender = @Gender
	AND		(colour = @Colr1 OR colour = @Colr2);

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P05]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P05: Dead Horses
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P05]
	-- stored procedure parameters
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.5  List the name and year of death of each dead horse. Sort the results into descending order on year of death.
	SELECT	horse_name,
			died
	FROM	HORSE
	WHERE	died IS NOT NULL

	ORDER BY died DESC;
			

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P06]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P06: Name of Each Type of Event
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P06]
	-- stored procedure parameters
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.6  List the name of each type of event. Do not list duplicate event names.
	SELECT	DISTINCT event_name
	FROM	[EVENT];			

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P07]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P07: Event Code (100 < x < 200)
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P07]
	-- stored procedure parameters
	@LwrBnd	MONEY = 100,
	@UprBnd	MONEY = 200, 
	@Place	TINYINT = 1
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.7  List the event_code of each event which has a first prize of between 100 and 200 dollars.
	SELECT	event_code
	FROM	PRIZE			
	WHERE	prizemoney BETWEEN @LwrBnd AND @UprBnd
	AND		place = @Place;


END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P08]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P08: White Horses
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P08]
	-- stored procedure parameters
	@Colr NVARCHAR(8) = 'White'
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.8  List the names of all horses whose colour is “white”.
	SELECT	horse_name
	FROM	HORSE			
	WHERE	colour = @Colr;

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S1P09]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P09: Live Horses
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P09]
	-- stored procedure parameters
	@p1 int = 0, 
	@p2 int = 0
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.9  List the horse_id and name of every horse that is still alive and was born before 1990. Order by horse_id
	SELECT	horse_id,
			horse_name
	FROM	HORSE			
	WHERE	died IS NOT NULL 
			AND born BETWEEN 1970 AND 1990
			
	ORDER BY horse_id;

END
GO

/****** Object:  StoredProcedure [dbo].[usp_S1P10]    Script Date: 3/03/2021 12:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ---------------------------------------------
-- S1P10: Name and Year of Dead Horses
-- ---------------------------------------------
CREATE PROCEDURE [dbo].[usp_S1P10]
	-- stored procedure parameters
	@p1 int = 0, 
	@p2 int = 0
AS
BEGIN
	SET NOCOUNT ON;

	-- 1.10  List the name and year of birth of each horse that is now dead, and was born in either 1976, 1978, 1980 or 1981.
	SELECT	horse_name,
			born
	FROM	HORSE			
	WHERE	born IN ('1976', '1978', '1980', '1981');

END
GO

USE [ThirlemereThoroughbreds]
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P01]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P01] 
	-- Add the parameters for the stored procedure here
	@p1 int = 0, 
	@p2 int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 2.1 List the event_id and event_name for each event, together with the name of the judge who is judging it. 
	-- (hint - join the event and judge tables)
	SELECT	ev.event_id,
			ev.event_name,
			j.judge_name
	FROM	[EVENT] AS ev,
			JUDGE AS j
	WHERE	ev.judge_id = j.judge_id
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P02]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P02] 
	-- Add the parameters for the stored procedure here
	@Place	TINYINT = 1

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 2.2 List the name of each horse who has been awarded a first place. Do not display the name of a horse more than once
	SELECT	DISTINCT h.horse_name
	FROM	HORSE AS h, -- the 'AS' keyword is optional
			ENTRY e
	WHERE	h.horse_id = e.horse_id
	AND		e.place = @Place
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P03]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P03]
	-- Add the parameters for the stored procedure here


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 2.3 For each event that a horse has entered. List the name of the horse together with the name of the event, and its placing in that event (if any).

	SELECT	h.horse_name AS [Horse Name],
			v.event_name [Event Name],
			e.place AS [Horse's Result]
	FROM	HORSE h,
			[ENTRY] e,
			[EVENT] v
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = v.event_id

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P04]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P04]
	-- Add the parameters for the stored procedure here


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 2.4 For each event, list the name of the event, the name and address of the show that it is in, and the name and address of the judge who is judging it.
	
	SELECT	v.event_name [Event Name],
			s.show_name [Show Name],
			s.show_address [Show Address],
			j.judge_name [Judge Name],
			j.address [Judge Address]
	FROM	[EVENT] v,
			SHOW s,
			JUDGE j
	WHERE	v.show_id = s.show_id
	AND		v.judge_id = j.judge_id

END
GO

CREATE PROCEDURE usp_S2P05
	-- Add the parameters for the stored procedure here
	@ShowName		NVARCHAR(15) = 'Dubbo'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 2.5 For all events at the show named “Dubbo”, list the date of the show, the judge name and the event name.
	SELECT		CONVERT(NVARCHAR(8), s.show_held, 3),
				j.judge_name,
				ev.event_name
	FROM		SHOW s,
				[EVENT] ev,
				JUDGE j
	WHERE		ev.show_id = s.show_id
	AND			j.judge_id = ev.judge_id
	AND			s.show_name = @ShowName

END

/****** Object:  StoredProcedure [dbo].[usp_S2P06]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P06]
	-- Add the parameters for the stored procedure here
	@Place TINYINT = 1

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 2.6 For each event with a first prize, list the event name and the first prize money
	SELECT	p.prizemoney,
			v.event_name
	FROM	[EVENT] v,
			PRIZE p
	WHERE	v.event_id = p.event_code
	AND		p.place = @Place

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P07]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P07]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- 2.7 List event_id, horse_id, place and money. Sort the results into order on event_id then horse_id.	
	SELECT	v.event_id [Event ID],
			e.horse_id [Horse ID],
			p.place [Place],
			-- '$' + CONVERT(NVARCHAR(10), p.prizemoney) [Prize]
			'$' + CAST(p.prizemoney AS NVARCHAR(10)) [Prize]
	FROM	[EVENT] v,
			[ENTRY] e,
			PRIZE p
	WHERE	e.event_id = v.event_id
	AND		v.event_id = p.event_code
	AND		e.place = p.place

	ORDER BY e.event_id, e.horse_id

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P08]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P08] 
	-- Add the parameters for the stored procedure here
	@Prize TINYINT = 1

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 2.8 For each event with a first prize, list the show name, event name and first prize money
	SELECT	sh.show_name [Show Name],
			ev.event_name [Event Name],
			'$' + CAST(p.prizemoney AS NVARCHAR(10)) [Prize Money]
	FROM	[EVENT] ev,
			PRIZE p,
			SHOW sh
	WHERE	ev.event_id = p.event_code
	AND		ev.show_id = sh.show_id
	AND		p.place = @Prize

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P09]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P09] 
	-- Add the parameters for the stored procedure here
	@Judge NVARCHAR(15) = 'Green'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 2.9 List the horse name, show name, event name and place for all horses in events judged by “Green”.
	SELECT	h.horse_name [Horse Name],
			s.show_name [Show Name],
			ev.event_name [Event Name],
			p.place [Place]
	FROM	JUDGE j,
			[EVENT] ev,
			[ENTRY] e,
			SHOW s,
			HORSE h,
			PRIZE p
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.judge_id = j.judge_id
	AND		ev.event_id = p.event_code
	AND		ev.show_id = s.show_id
	AND		p.place = e.place

	-- restrictions
	AND		j.judge_name = @Judge

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S2P10]    Script Date: 14/03/2021 22:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 10 March 2021
-- Description:	SQL Section 2 - Problem Solutions (Assignment 4)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S2P10] 
	-- Add the parameters for the stored procedure here
	@Judge NVARCHAR(15) = 'Smith',
	@Address NVARCHAR(30) = 'Melbourne',
	@Horse1 NVARCHAR(15) = 'Star',
	@Horse2 NVARCHAR(15) = 'Flash'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 2.10 List the event_id and event name for all events entered by Star or Flash and judged by Smith from Melbourne.
	SELECT	e.event_id [Event ID],
			ev.event_name [Event Name]
	FROM	HORSE h,
			[ENTRY] e,
			[EVENT] ev,
			JUDGE j
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.judge_id = j.judge_id

	-- restrictions
	AND		j.judge_name = @Judge
	AND		j.address = @Address
	AND		(h.horse_name = @Horse1 OR h.horse_name = @Horse2)

END
GO


USE [ThirlemereThoroughbreds]
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P01]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P01] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.1 List the name of each event type, and the number of times that event is recorded as having been on.
	SELECT	event_name,
			COUNT(*) AS [number_of_events_with_this_name]
	FROM	[EVENT]
	GROUP BY event_name
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P02]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P02]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.2 List the name of each show, and the number of different times it has been held. List the show which has been held most often first.
	SELECT	show_name,
			COUNT(*) AS [number_of_times_held]
	FROM	SHOW
	GROUP BY show_name
	ORDER BY number_of_times_held
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P03]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P03]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.3 List the number of judges having each name.
	SELECT	judge_name,
			COUNT(*) AS [number_of_judges_with_this_name]
	FROM	JUDGE
	GROUP BY judge_name
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P04]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P04] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.4 For each show, list the show name, date held and the number of events at that show.
	SELECT	sh.show_name,
			CONVERT(NVARCHAR(8), sh.show_held, 3) [show_held],
			COUNT(sh.show_id) AS [events_contested]
	FROM	SHOW sh,
			[EVENT] ev
	WHERE	ev.show_id = sh.show_id
	GROUP BY show_name, show_held

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P05]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P05]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.5 For each horse that has won a prize, list the horse name, horse_id and total prize money won.
	SELECT	h.horse_name,
			h.horse_id,
			SUM(p.prizemoney) [total_prizemoney_won]
	FROM	HORSE h,
			PRIZE p, 
			[ENTRY] e, 
			[EVENT] ev
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.event_id = p.event_code
	AND		p.place = e.place
	
	AND		e.place IS NOT NULL

	GROUP BY h.horse_name, h.horse_id

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P06]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P06]
	-- Add the parameters for the stored procedure here
	@MinPrize MONEY = '110'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.6 For each horse which has won total prize money of at least $110, list the horse name, horse_id and total prize money won.
	SELECT	h.horse_name,
			h.horse_id,
			SUM(p.prizemoney) [total_prizemoney_won]
	FROM	HORSE h,
			PRIZE p, 
			[ENTRY] e, 
			[EVENT] ev
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.event_id = p.event_code
	AND		p.place = e.place
	
	AND		e.place IS NOT NULL
	
	GROUP BY h.horse_name, h.horse_id
	HAVING	SUM(p.prizemoney) >= @MinPrize

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P07]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P07]
	-- Add the parameters for the stored procedure here
	@Place1 TINYINT = 1,
	@Place2 TINYINT = 2

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.7 Produce a table similar to that below, showing, for first and second places, the number of times each prize was given, the total prize money awarded, the greatest prize, the smallest prize, and the average prize. (The attribute names in your solution may be different).
	SELECT	p.place,
			COUNT(*) AS [Times Awarded],
			SUM(prizemoney) [Total],
			MAX(prizemoney) [Maximum],
			MIN(prizemoney) [Minimum],
			AVG(prizemoney) [Average]
	FROM	PRIZE p,
			[EVENT] ev,
			[ENTRY] e
	WHERE	e.place = p.place
	AND		e.event_id = ev.event_id
	AND		e.event_id = p.event_code
	
	-- constraints
	AND (p.place = @Place1 OR p.place = @Place2)
	GROUP BY p.place

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P08]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P08]
	-- Add the parameters for the stored procedure here
	@Place1 TINYINT = 1,
	@Place2 TINYINT = 2

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.8 List the horse_id and horse name for each horse that has been placed in the top 2 more than once.
	SELECT	h.horse_id,
			h.horse_name,
			COUNT(*) [times_in_top_2_places]
	FROM	HORSE h,
			[ENTRY] e,
			[EVENT] ev,
			PRIZE p
	-- links between tables
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.event_id = p.event_code
	AND		e.place = p.place
		
	-- constraints
	AND (e.place = @Place1 OR e.place = @Place2)
	GROUP BY h.horse_id, h.horse_name
	HAVING COUNT(*) > 1

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S3P09]    Script Date: 15/03/2021 12:11:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 14 March 2021
-- Description:	SQL Section 3 - Problem Solutions (Assignment 5)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S3P09]
	-- Add the parameters for the stored procedure here
	@JudgeName		NVARCHAR(15) = 'Smith',
	@JudgeAddress	NVARCHAR(30) = 'Melbourne'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 3.9 List the name of each horse, and the number of times it has competed in an event judged by Smith of Melbourne.
	SELECT	h.horse_name,
			COUNT(*) [number_of_times_competing]
	FROM	HORSE h, 
			[ENTRY] e,
			[EVENT] ev,
			JUDGE j
	
	-- links between tables
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.judge_id = j.judge_id

	-- constraints
	AND		j.judge_name = @JudgeName
	AND		j.address = @JudgeAddress
	GROUP BY h.horse_name

END
GO

USE [ThirlemereThoroughbreds]
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P01]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P01]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.1 List the name of each show, together with the date that it was held. Format the date into the following format exactly; Wednesday 13 September, 1995

	SELECT	sh.show_name [Show Name],
			DATENAME(WEEKDAY, sh.show_held) + ' ' + FORMAT(sh.show_held,'dd MMMM, yyyy') [Date Held]
	FROM	SHOW sh
	
	-- constraints
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P02]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P02]
	-- Add the parameters for the stored procedure here
	@Year NVARCHAR(4) = '1996'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.2 List the name of each event hosted at a show held in 1996.
	SELECT	ev.event_name [Show Name]
	FROM	[EVENT] ev,
			SHOW sh
	WHERE	ev.show_id = sh.show_id
	
	-- constraints
	AND CONVERT(NVARCHAR(4), DATEPART(YEAR, sh.show_held)) = @Year 
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P03]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P03]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.3 List the name of each horse, the name of the event and the show that the event was in, and its age at the time of the event
	SELECT	h.horse_name,
			ev.event_name,
			sh.show_name,
			((CONVERT(SMALLINT, DATEPART(YEAR, sh.show_held)))-(CONVERT(SMALLINT, h.born))) [age_at_the_time]
	FROM	HORSE h, 
			[ENTRY] e,
			[EVENT] ev,
			SHOW sh
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.show_id = sh.show_id

	-- constraints

	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P04]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P04]
	-- Add the parameters for the stored procedure here
	@Month SMALLINT = 7

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.4 List the name of each event that has been held in July, together with the number of times it was held in that month
	SELECT		ev.event_name,
				COUNT(*) [times_held_in_july]
	FROM		[EVENT] ev,
				SHOW sh
	WHERE		sh.show_id = ev.show_id
	AND			CONVERT(NVARCHAR(4), DATEPART(MONTH, sh.show_held)) = @Month
	GROUP BY	ev.event_name

	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P05]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P05]
	-- Add the parameters for the stored procedure here
	@Year SMALLINT = 2009
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.5 List the horse_id, horse name and the number of years between the horse’s year of death and 2009. Sort the results so that the horse which has been dead the longest appears first.
	SELECT		h.horse_id,
				h.horse_name,
				h.died,
				h.born,
				(@Year - h.died) [NumberOfYearsDeceased]
	FROM		HORSE h
	WHERE		h.died IS NOT NULL
	ORDER BY	NumberOfYearsDeceased DESC;
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P06]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P06]
	-- Add the parameters for the stored procedure here
	@Weekday NVARCHAR(10) = 'Saturday'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.6 List the show name of any shows that have been held on a “Saturday”.
	SELECT	sh.show_name
	FROM	SHOW sh
	WHERE	DATENAME(WEEKDAY, sh.show_held) = @Weekday
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P07]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P07]
	-- Add the parameters for the stored procedure here
	@Address NVARCHAR(30) = '%Wingewarra St%',
	@Place1 NVARCHAR(15) = 'Dubbo',
	@Place2 NVARCHAR(15) = 'Castle Hill'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.7 List the number of days between the Dubbo show held at the “Wingewarra St” show ground and the Castle Hill show	
	SELECT	DATEDIFF(day, sh1.show_held, sh2.show_held) [NoOfDaysBetweenShows]
	FROM	SHOW sh1,
			SHOW sh2
	WHERE	((sh1.show_name = @Place1) AND (sh1.show_address LIKE @Address))
	AND		sh2.show_name = @Place2
						  
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S4P08]    Script Date: 20/03/2021 12:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 4 - Problem Solutions (Assignment 6)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S4P08]
	-- Add the parameters for the stored procedure here
	@Year	SMALLINT = 2009

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 4.8 List the id and name of each horse that has competed at a show, also list the number of years between their last competition and 2009.
	SELECT	h.horse_id,
			h.horse_name,
			@Year - DATEPART(YEAR, MAX(s.show_held)) [YearsToCompete]
	FROM	HORSE h,
			[ENTRY] e,
			[EVENT] ev,
			SHOW s
	
	-- link tables
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.show_id = s.show_id

	-- question constraints
	GROUP BY h.horse_id, h.horse_name
		
END
GO

USE [ThirlemereThoroughbreds]
GO
/****** Object:  StoredProcedure [dbo].[usp_S5P01]    Script Date: 20/03/2021 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 5 - Problem Solutions (Assignment 7)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S5P01]
	-- Add the parameters for the stored procedure here
	@ShowID	NCHAR(2) = '01'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 5.1 Using subqueries only (without products of any kind), list the name of every judge who has judged an event at the show with an id of ‘01’.
	SELECT	DISTINCT j.judge_name
	FROM	JUDGE j
	WHERE	EXISTS (SELECT		ev.show_id
					FROM		[EVENT] ev
					WHERE		j.judge_id = ev.judge_id
					AND			ev.show_id = @ShowID)
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S5P02]    Script Date: 20/03/2021 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 5 - Problem Solutions (Assignment 7)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S5P02]
	-- Add the parameters for the stored procedure here
	@Year	SMALLINT = 1995

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 5.2 Using subqueries only (without products of any kind), list the name of every judge who has judged an event at the Dubbo show in 1995.
	SELECT	DISTINCT j.judge_name
	FROM	JUDGE j
	WHERE	EXISTS (SELECT		ev.show_id
					FROM		[EVENT] ev,
								SHOW sh
					WHERE		j.judge_id = ev.judge_id
					AND			ev.show_id = sh.show_id
					AND			DATEPART(year, sh.show_held) = @Year)
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S5P03]    Script Date: 20/03/2021 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 5 - Problem Solutions (Assignment 7)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S5P03]
	-- Add the parameters for the stored procedure here
	@Horse1		NVARCHAR(15) = 'Star',
	@Horse2		NVARCHAR(15) = 'Flash',
	@JName		NVARCHAR(15) = 'Smith',
	@JAddress	NVARCHAR(30) = 'Melbourne'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 5.3 Using subqueries only (without products of any kind), list the event_id and event name for all events entered by Star or Flash and judged by Smith from Melbourne.
	SELECT	ev.event_id,
			ev.event_name
	FROM	[EVENT] ev
	WHERE	EXISTS (SELECT		h.horse_name
					FROM		HORSE h,
								[ENTRY] e
					WHERE		h.horse_id = e.horse_id
					AND			e.event_id = ev.event_id
					AND			((h.horse_name = @Horse1) OR (h.horse_name = @Horse2)))
	AND		EXISTS (SELECT		j.judge_name
					FROM		JUDGE j
					WHERE		j.judge_id = ev.judge_id
					AND			j.judge_name = @JName
					AND			j.address = @JAddress)
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S5P04]    Script Date: 20/03/2021 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 5 - Problem Solutions (Assignment 7)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S5P04]
	-- Add the parameters for the stored procedure here
	@JAddress	NVARCHAR(30) = 'Melbourne',
	@Gender		NCHAR(1) = 'S'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 5.4 Using subqueries only (without products of any kind), list the name of each judge who does not live in Melbourne, and who has judged an event entered by any horse with a gender of ‘S’.
	SELECT	j.judge_name
	FROM	JUDGE j
	WHERE	EXISTS (SELECT		j.address
					WHERE		j.address != @JAddress)
	AND		EXISTS (SELECT		h.gender
					FROM		HORSE h, 
								[ENTRY] e,
								[EVENT] ev
					WHERE		h.horse_id = e.horse_id
					AND			e.event_id = ev.event_id
					AND			ev.judge_id = j.judge_id
					AND			h.gender = @Gender)
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S5P05]    Script Date: 20/03/2021 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 5 - Problem Solutions (Assignment 7)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S5P05]
	-- Add the parameters for the stored procedure here
	@JAddress	NVARCHAR(30) = 'Melbourne',
	@Gender		NCHAR(1) = 'S'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 5.5 Repeat the previous query using only products. (5.4 Using subqueries only (without products of any kind), list the name of each judge who does not live in Melbourne, and who has judged an event entered by any horse with a gender of ‘S’.)
	SELECT	DISTINCT j.judge_name
	FROM	JUDGE j,
			HORSE h,
			[ENTRY] e,
			[EVENT] ev
	WHERE	h.horse_id = e.horse_id
	AND		e.event_id = ev.event_id
	AND		ev.judge_id = j.judge_id
	and		j.address != @JAddress
	AND		h.gender = @Gender

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S5P06]    Script Date: 20/03/2021 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 5 - Problem Solutions (Assignment 7)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S5P06]
	-- Add the parameters for the stored procedure here
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 5.6 List the name and id of each horse, together with one of the following text values, as appropriate, “Alive” or “Dead”. Sort by horse_id.
	SELECT	h.horse_name,
			h.horse_id,
			'Alive' [Status]
	FROM	HORSE h
	WHERE	h.died IS NULL

	UNION

	SELECT	h.horse_name,
			h.horse_id,
			'Dead'
	FROM	HORSE h
	WHERE	h.died IS NOT NULL

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S5P07]    Script Date: 20/03/2021 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 19 March 2021
-- Description:	SQL Section 5 - Problem Solutions (Assignment 7)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S5P07]
	-- Add the parameters for the stored procedure here
	@Place	TINYINT = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 5.7 List the name of each horse, together with the number of events in which it has been awarded first place. Horses who have never won a first place should also be listed with a count of zero. Sort the list into descending order on number of wins.
	
	SELECT		h.horse_name, 
				SUM(IIf(e.place = @Place, 1, 0)) [number_of_wins]
	FROM		HORSE h LEFT JOIN [ENTRY] e
	ON			h.horse_id = e.horse_id
	GROUP BY	h.horse_id, h.horse_name

	ORDER BY	number_of_wins DESC, h.horse_name

END
GO

USE [ThirlemereThoroughbreds]
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P01a]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P01a] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.1 Create a copy of each of the tables (include the data) in the Thirlemere Thoroughbreds database. Prefix the names of the table copies with the word ‘New’
	SELECT	*
	INTO	NewENTRY
	FROM	[ENTRY] 
	


END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P01b]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P01b] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.1 Create a copy of each of the tables (include the data) in the Thirlemere Thoroughbreds database. Prefix the names of the table copies with the word ‘New’
	SELECT	* 
	INTO	NewHORSE
	FROM	HORSE 
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P01c]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P01c] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.1 Create a copy of each of the tables (include the data) in the Thirlemere Thoroughbreds database. Prefix the names of the table copies with the word ‘New’
	SELECT	*
	INTO	NewEvent
	FROM	[EVENT] 
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P01d]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P01d] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.1 Create a copy of each of the tables (include the data) in the Thirlemere Thoroughbreds database. Prefix the names of the table copies with the word ‘New’
	SELECT	* 
	INTO	NewJudge
	FROM	JUDGE
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P01e]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P01e] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.1 Create a copy of each of the tables (include the data) in the Thirlemere Thoroughbreds database. Prefix the names of the table copies with the word ‘New’
	SELECT	* 
	INTO	NewShow
	FROM	SHOW 
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P01f]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P01f] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.1 Create a copy of each of the tables (include the data) in the Thirlemere Thoroughbreds database. Prefix the names of the table copies with the word ‘New’
	SELECT	* 
	INTO	NewPRIZE
	FROM	PRIZE  
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P02]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P02] 
	-- Add the parameters for the stored procedure here
	@HorseID	NCHAR(3) = '401'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.2 An error has been discovered in the NewHorse table. The Horse with horse_id ‘401’ is incorrectly indicated as ‘Snowy’ change that horse’s name to ‘Snappy’
	UPDATE	NewHORSE 
	SET		horse_name = 'Snappy'
	WHERE	horse_id = @HorseID
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P03]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P03] 
	-- Add the parameters for the stored procedure here
	@EventID	NCHAR(4) = '0102',
	@Place		TINYINT = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.3 The prizemoney for first place in the NewPrize table for event 0102 is indicated as $10. The event organisers have decided that this prize should be $20. Modify the data in the NewPrize table to reflect this change.
	UPDATE	NewPRIZE 
	SET		prizemoney = '20'
	WHERE	event_code = @EventID
	AND		place = @Place
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P04]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P04] 
	-- Add the parameters for the stored procedure here
	@JudgeName	NVARCHAR(15) = 'Smith'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.4 Judge Smith from Sydney has recently married and changed her name from Smith to Smithers. Update the data in the NewJudge table to reflect this change.
	UPDATE	NewJUDGE
	SET		judge_name = 'Smithers'
	WHERE	judge_name = @JudgeName
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P05]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P05] 
	-- Add the parameters for the stored procedure here
	@Month		NVARCHAR(10) = 'April',
	@Unlucky	NVARCHAR(30) = '%13%'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.5 The organisers of the shows have recently suffered a bout of ‘superstition’. They would like to delete all shows which have the value ‘13’ in the address and which were held in ‘April’ from the NewShow table. Make sure you use the word ‘April’ and not the number ‘04’ to select the records to be deleted.
	/*DELETE	FROM	NewSHOW
	WHERE	
	AND		show_address LIKE @Unlucky*/

	DELETE	FROM	NewSHOW
	WHERE	CONVERT(NVARCHAR(10), DATENAME(MONTH, show_held)) = @Month
	AND		show_address LIKE @Unlucky

	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P06]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P06] 
	-- Add the parameters for the stored procedure here
	@Month		NVARCHAR(10) = 'April',
	@Unlucky	NVARCHAR(30) = '%13%'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.6 Delete all of the dead horses from the NewHorse table
	/*DELETE	FROM	NewSHOW
	WHERE	CONVERT(NVARCHAR(10), DATENAME(MONTH, show_held)) = @Month
	AND		show_address LIKE @Unlucky*/

	DELETE	FROM	NewHORSE
	WHERE	died IS NOT NULL

	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_S7P07]    Script Date: 26/03/2021 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 7 - Changing Data (Assignment 8)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S7P07] 
	-- Add the parameters for the stored procedure here
	@NewPrize	MONEY = 100,
	@Place		TINYINT = 1

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 7.7 Increase the value of all first prizemoney by $100
	UPDATE	NewPRIZE
	SET		prizemoney = @NewPrize
	WHERE	place = @Place

	
END
GO

USE [ThirlemereThoroughbreds]
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P01]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P01] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.1 Re-do problem 2.1 using an INNER JOIN instead of a product. 
	-- (2.1 List the event_id and event_name for each event, together with the name of the judge who is judging it. 
	-- (hint - join the event and judge tables))
	/*SELECT	[EVENT].event_id, [EVENT].event_name, JUDGE.judge_name
	FROM	([EVENT] INNER JOIN	JUDGE ON [EVENT].judge_id = JUDGE.judge_id)*/

	SELECT	ev.event_id,
			ev.event_name,
			j.judge_name
	FROM	[EVENT] AS ev,
			JUDGE AS j
	WHERE	ev.judge_id = j.judge_id






END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P02]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P02]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.2 Re-do problem 2.7 using an INNER JOIN instead of a product.
	-- (2.7 List event_id, horse_id, place and money. Sort the results into order on event_id then horse_id.)
	SELECT		ev.event_id,
				e.horse_id,
				p.place,
				'$' + CAST(p.prizemoney AS NVARCHAR(10))
	FROM		(([ENTRY] e INNER JOIN	[EVENT] ev	ON e.event_id = ev.event_id)
							INNER JOIN	PRIZE p		ON (ev.event_id = p.event_code AND e.place = p.place)
				)
	ORDER BY	ev.event_id, e.horse_id

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P03]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P03]
	-- Add the parameters for the stored procedure here
	@Judge NVARCHAR(15) = 'Smith',
	@Address NVARCHAR(30) = 'Melbourne',
	@Horse1 NVARCHAR(15) = 'Star',
	@Horse2 NVARCHAR(15) = 'Flash'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.3 Re-do problem 2.10 using an INNER JOIN instead of a product
	-- (2.10 List the event_id and event name for all events entered by Star or Flash and judged by Smith from Melbourne.)
	SELECT	e.event_id, 
			ev.event_name
	FROM	(((HORSE h	INNER JOIN	[ENTRY] e	ON	h.horse_id = e.horse_id)
						INNER JOIN	[EVENT] ev	ON	e.event_id = ev.event_id)
						INNER JOIN	JUDGE j		ON	ev.judge_id = j.judge_id
			)
	WHERE	j.judge_name = @Judge
	AND		j.address = @Address
	AND		(h.horse_name = @Horse1 OR h.horse_name = @Horse2)

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P04]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P04]
	-- Add the parameters for the stored procedure here
	@MinPrize MONEY = '110'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.4 Re-do problem 3.6 using an INNER JOIN instead of a product.
	-- (3.6 For each horse which has won total prize money of at least $110, list the horse name, horse_id and total prize money won.)
	SELECT	h.horse_name,
			h.horse_id,
			'$' + CAST(SUM(p.prizemoney) AS NVARCHAR(10)) 
	FROM	(((HORSE h	INNER JOIN	[ENTRY] e	ON	h.horse_id = e.horse_id)
						INNER JOIN	[EVENT] ev	ON	e.event_id = ev.event_id)
						INNER JOIN	PRIZE p		ON	(ev.event_id = p.event_code AND p.place = e.place)
			)
	WHERE	e.place	IS NOT NULL

	GROUP BY	h.horse_name, h.horse_id
	HAVING		SUM(p.prizemoney) >= @MinPrize

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P05]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P05]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.5 For each horse with a recorded sire (father), list the name of the horse, its year of birth, and the name of its sire. Sort into order on year of birth.
	SELECT	horse.horse_name,
			horse.born [born],
			sire.horse_name
	FROM	((HORSE horse	INNER JOIN	HORSE sire	ON	horse.sire = sire.horse_id)
			)
	WHERE	horse.sire	IS NOT NULL

	ORDER BY	horse.born

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P06]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P06]
	-- Add the parameters for the stored procedure here
	@Horse	NVARCHAR(15) = 'Flash'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.6 List the name of the sire (father) of the horse called “Flash”.
	SELECT	sire.horse_name
	FROM	((HORSE horse	INNER JOIN	HORSE sire	ON	horse.sire = sire.horse_id)
			)
	WHERE	horse.horse_name = @Horse

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P07]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P07]
	-- Add the parameters for the stored procedure here
	@Colour		NVARCHAR(8) = 'White',
	@Gender		NCHAR(1) = 'M'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.7 For each white mare with a white dam (mother), list the name of the horse and its dam
	SELECT	horse.horse_name,
			mother.horse_name [mother.horse_name]
	FROM	((HORSE horse	INNER JOIN	HORSE mother	ON	horse.dam = mother.horse_id)
			)
	WHERE	horse.colour = @Colour
	AND		mother.colour = @Colour
	AND		horse.gender = @Gender

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P08]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P08]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.8 For each horse that has a recorded paternal grandsire (sire of its sire), list the names of the horse, of its sire and of its paternal grandsire.
	SELECT	horse.horse_name		[horse.horse_name],
			sire.horse_name			[sire.horse_name],	
			grandsire.horse_name	[grandsire.horse_name]
	FROM	((HORSE horse	INNER JOIN	HORSE sire		ON	horse.sire = sire.horse_id)
							INNER JOIN	HORSE grandsire ON	sire.sire = grandsire.horse_id
			)
	WHERE	horse.sire	IS NOT NULL
	AND		sire.sire	IS NOT NULL

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P09]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P09]
	-- Add the parameters for the stored procedure here
	@Place1	TINYINT = 1,
	@Place2	TINYINT = 2,
	@Place3	TINYINT = 3

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.9 For each event with at least three prizes, list the event_id and the prize money available for first, second and third prize on one line. Order the table by event_id.
	SELECT	DISTINCT ev.event_id,
			'$' + CAST(p1.prizemoney AS NVARCHAR(10))	[first.prizemoney],
			'$' + CAST(p2.prizemoney AS NVARCHAR(10))	[second.prizemoney],	
			'$' + CAST(p3.prizemoney AS NVARCHAR(10))	[third.prizemoney]
	FROM	(((([EVENT] ev	INNER JOIN PRIZE p1		ON ev.event_id = p1.event_code)
							INNER JOIN PRIZE p2		ON ev.event_id = p2.event_code)
							INNER JOIN PRIZE p3		ON ev.event_id = p3.event_code)
							INNER JOIN [ENTRY] e	ON e.event_id = ev.event_id
			)
	WHERE	p1.place = @Place1
	AND		p2.place = @Place2
	AND		p3.place = @Place3

	ORDER BY	ev.event_id

END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P10]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P10]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.10 For each horse that has been entered in the same event as its sire (father), list the names of the two horses and of the event.
	SELECT	h.horse_name	[child.horse_name],
			s.horse_name	[sire.horse_name],
			ev.event_name	[event_name]
	FROM	(((([HORSE] h	INNER JOIN [HORSE] s	ON h.sire = s.horse_id)
							INNER JOIN [ENTRY] e1	ON h.horse_id = e1.horse_id)
							INNER JOIN [ENTRY] e2	ON s.horse_id = e2.horse_id)
							INNER JOIN [EVENT] ev	ON (ev.event_id = e1.event_id
													AND ev.event_id = e2.event_id)
			)
		--WHERE	e.horse_id = h.sire


END
GO
/****** Object:  StoredProcedure [dbo].[usp_S8P11]    Script Date: 26/03/2021 23:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kyra Alday
-- Create date: 26 March 2021
-- Description:	SQL Section 8 - Other Types of Join (Assignment 9)
-- =============================================
CREATE PROCEDURE [dbo].[usp_S8P11]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 8.11 For each judge, list the judge_id, Judge_name and the event_id of each event they have judged. Include judges who have not judged any event (Hint - use LEFT OUTER JOIN.)
	SELECT	j.judge_id,
			j.judge_name,
			ev.event_id
	FROM	((JUDGE j LEFT OUTER JOIN [EVENT] ev ON j.judge_id = ev.judge_id)
			) 

END
GO
