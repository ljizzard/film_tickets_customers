DROP TABLE customers;
DROP TABLE films;
DROP TABLE tickets;

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  funds INT
);

CREATE TABLE films(
  id SERIAL PRIMARY KEY,
  title VARCHAR,
  price INT
);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  id_customer INT REFERENCES customers(id) ON DELETE CASCADE,
  id_film INT REFERENCES films(id) ON DELETE CASCADE
);
