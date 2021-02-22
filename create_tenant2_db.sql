CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  address VARCHAR(400)
);
INSERT INTO users(first_name, last_name, email) VALUES
 ('Jane', 'Doe', 'janedoe@email.com');