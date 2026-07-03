-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE stars (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    galaxy_id INTEGER REFERENCES galaxies(id)
);

CREATE TABLE planets (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    orbital_period_in_years FLOAT NOT NULL,
    star_id INTEGER REFERENCES stars(id)
);

CREATE TABLE moons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    planet_id INTEGER REFERENCES planets(id)
);

INSERT INTO galaxies (name)
VALUES ('Milky Way');

INSERT INTO stars (name, galaxy_id)
VALUES
('The Sun', 1),
('Proxima Centauri', 1),
('Gliese 876', 1);

INSERT INTO planets (name, orbital_period_in_years, star_id)
VALUES
('Earth', 1.00, 1),
('Mars', 1.88, 1),
('Venus', 0.62, 1),
('Neptune', 164.8, 1),
('Proxima Centauri b', 0.03, 2),
('Gliese 876 b', 0.23, 3);

INSERT INTO moons (name, planet_id)
VALUES
('The Moon', 1),
('Phobos', 2),
('Deimos', 2),
('Triton', 4);

-- CREATE TABLE planets
-- (
--   id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   orbital_period_in_years FLOAT NOT NULL,
--   orbits_around TEXT NOT NULL,
--   galaxy TEXT NOT NULL,
--   moons TEXT[]
-- );

-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');