USE [Console Games]
GO

CREATE TABLE console_games (
    game_rank integer,
    game_name varchar(1200),
    platform_name varchar(1200),
    game_year integer,
    genre varchar(200),
    publisher varchar(1200),
    na_sales float,
    eu_sales float,
    jp_sales float,
    other_sales float
	)

INSERT INTO console_games
SELECT *
FROM [dbo].[RAW ConsoleGames]

USE [Console Games]
GO

CREATE TABLE console_dates (
    platform_name varchar(120),
    first_retail_availability date,
    discontinued date,
    units_sold_mill decimal,
    platform_comment varchar(120)    
)

UPDATE [dbo].[RAW ConsoleDates]
SET [Discontinued] = NULL 
WHERE [Discontinued] = ''

INSERT INTO console_dates
SELECT *
FROM [dbo].[RAW ConsoleDates]
