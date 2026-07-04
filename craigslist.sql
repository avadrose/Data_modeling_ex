DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    preferred_region_id INTEGER REFERENCES regions(id)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    post_text TEXT NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id),
    region_id INTEGER NOT NULL REFERENCES regions(id),
    location TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts_categories (
    post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
    category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    PRIMARY KEY (post_id, category_id)
);

INSERT INTO regions (name)
VALUES ('Columbus');

INSERT INTO users (username, email, preferred_region_id)
VALUES ('ava', 'ava@example.com', 1);

INSERT INTO categories (name)
VALUES ('Furniture');

INSERT INTO posts (title, post_text, user_id, region_id, location)
VALUES ('Wooden Desk', 'Solid oak desk for sale.', 1, 1, 'Dublin, OH');

INSERT INTO posts_categories (post_id, category_id)
VALUES (1, 1);