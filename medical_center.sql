DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    specialty TEXT
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birth_date DATE
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    doctor_id INTEGER NOT NULL REFERENCES doctors(id),
    patient_id INTEGER NOT NULL REFERENCES patients(id),
    visit_date DATE NOT NULL,
    notes TEXT
);

CREATE TABLE diagnoses (
    id SERIAL PRIMARY KEY,
    visit_id INTEGER NOT NULL REFERENCES visits(id),
    disease_id INTEGER NOT NULL REFERENCES diseases(id)
);

INSERT INTO doctors (first_name, last_name, specialty)
VALUES ('Meredith', 'Grey', 'General Surgery');

INSERT INTO patients (first_name, last_name, birth_date)
VALUES ('Ava', 'Rose', '1996-04-14');

INSERT INTO diseases (name, description)
VALUES ('Flu', 'Viral infection');

INSERT INTO visits (doctor_id, patient_id, visit_date, notes)
VALUES (1, 1, '2026-07-03', 'Patient reported fever and body aches.');

INSERT INTO diagnoses (visit_id, disease_id)
VALUES (1, 1);