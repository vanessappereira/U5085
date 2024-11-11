CREATE DATABASE EuropeFootballLeagues;

CREATE TABLE
    Leagues (id INT PRIMARY KEY, league VARCHAR(50));

CREATE TABLE
    Teams (
        id INT PRIMARY KEY,
        team VARCHAR(50),
        league_id INT,
        FOREIGN KEY (league_id) REFERENCES Leagues (id)
    );

CREATE TABLE
    Matches (
        id INT PRIMARY KEY,
        HomeTeam_id INT,
        AwayTeam_id INT,
        HomeScore INT,
        AwayScore INT,
        Date DATE,
        FOREIGN KEY (HomeTeam_id) REFERENCES Teams (id),
        FOREIGN KEY (AwayTeam_id) REFERENCES Teams (id)
    );

-- 1. Construa uma função na base de dados EuropeFootballLeagues que devolva opcionalmente o número de jogos jogados em casa ou fora de casa para uma dada equipa.
DELIMITER / /
create function getNumberOfGames (teamID INT, isHome BIT) RETURNS INT DETERMINISTIC BEGIN DECLARE totalGames INT DEFAULT = 0;

IF isHome is null then
-- count both home and payed and away games
SELECT
    COUNT(*) INTO totalGames
FROM
    Matches
WHERE
    HomeTeam_id = teamID
    OR AwayTeam_id;

elseif isHome = 1 then
-- count only home games
SELECT
    COUNT(*) INTO totalGames
FROM
    Matches
WHERE
    HomeTeam_id = teamID;

else
-- count only away games
SELECT
    COUNT(*) INTO totalGames
FROM
    Matches
WHERE
    AwayTeam_id = teamID;

end if;

RETURN totalGames;

end / / DELIMITER;

-- 2. Construa uma função na base de dados EuropeFootballLeagues que devolva opcionalmente o número de vitórias em casa ou fora de casa para uma dada equipa.
-- Function to get the number of victories for a team
DELIMITER $$
CREATE FUNCTION getVictories (teamID INT, isHome BIT) RETURNS INT DETERMINISTIC BEGIN DECLARE victories INT DEFAULT 0;

IF isHome IS NULL THEN
-- Count both home and away victories
SELECT
    COUNT(*) INTO victories
FROM
    Matches
WHERE
    (
        HomeTeam_id = teamID
        AND HomeScore > AwayScore
    )
    OR (
        AwayTeam_id = teamID
        AND AwayScore > HomeScore
    );

ELSEIF isHome = 1 THEN
-- Count only home victories
SELECT
    COUNT(*) INTO victories
FROM
    Matches
WHERE
    HomeTeam_id = teamID
    AND HomeScore > AwayScore;

ELSE
-- Count only away victories
SELECT
    COUNT(*) INTO victories
FROM
    Matches
WHERE
    AwayTeam_id = teamID
    AND AwayScore > HomeScore;

END IF;

RETURN victories;

END $$ DELIMITER;

-- Exemplos:
SELECT
    getNumberOfGames (30, NULL); -- Total games for team with ID 30
SELECT
    getNumberOfGames (30, 1); -- Home games for team with ID 30
SELECT
    getNumberOfGames (30, 0); -- Away games for team with ID 30
SELECT
    getVictories (30, NULL); -- Total victories for team with ID 30
SELECT
    getVictories (30, 1); -- Home victories for team with ID 30
SELECT
    getVictories (30, 0); -- Away victories for team with ID 30