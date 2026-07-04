DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    city TEXT
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    team_id INTEGER NOT NULL REFERENCES teams(id)
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    season_id INTEGER NOT NULL REFERENCES seasons(id),
    home_team_id INTEGER NOT NULL REFERENCES teams(id),
    away_team_id INTEGER NOT NULL REFERENCES teams(id),
    match_date DATE NOT NULL,
    home_score INTEGER DEFAULT 0,
    away_score INTEGER DEFAULT 0,
    CHECK (home_team_id <> away_team_id)
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    match_id INTEGER NOT NULL REFERENCES matches(id),
    player_id INTEGER NOT NULL REFERENCES players(id),
    goal_time INTEGER
);

CREATE TABLE matches_referees (
    match_id INTEGER REFERENCES matches(id) ON DELETE CASCADE,
    referee_id INTEGER REFERENCES referees(id) ON DELETE CASCADE,
    PRIMARY KEY (match_id, referee_id)
);

INSERT INTO seasons (start_date, end_date)
VALUES ('2026-08-01', '2027-05-31');

INSERT INTO teams (name, city)
VALUES
('Columbus Crew', 'Columbus'),
('FC Cincinnati', 'Cincinnati');

INSERT INTO players (first_name, last_name, team_id)
VALUES
('John', 'Smith', 1),
('Mike', 'Jones', 2);

INSERT INTO referees (first_name, last_name)
VALUES
('Sarah', 'Brown');

INSERT INTO matches (season_id, home_team_id, away_team_id, match_date, home_score, away_score)
VALUES
(1, 1, 2, '2026-09-15', 2, 1);

INSERT INTO goals (match_id, player_id, goal_time)
VALUES
(1, 1, 25),
(1, 1, 70),
(1, 2, 55);

INSERT INTO matches_referees (match_id, referee_id)
VALUES
(1, 1);