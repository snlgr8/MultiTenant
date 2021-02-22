-- https://blog.lftechnology.com/designing-a-secure-and-scalable-multi-tenant-application-on-node-js-15ae13dda778
-- DB scripts 
-- User: common_db_user
-- DROP USER common_db_user;

CREATE USER common_db_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION;
  
  
  -- User: tenant1_user
-- DROP USER tenant1_user;

CREATE USER tenant1_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;
  
  
  -- User: tenant2_user
-- DROP USER tenant2_user;

CREATE USER tenant2_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;



-- Database: common_db

-- DROP DATABASE common_db;

CREATE DATABASE common_db
    WITH 
    OWNER = common_db_user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- Database: tenant1_db

-- DROP DATABASE tenant1_db;

CREATE DATABASE tenant1_db
    WITH 
    OWNER = tenant1_user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- Database: tenant2_db

-- DROP DATABASE tenant2_db;

CREATE DATABASE tenant2_db
    WITH 
    OWNER = tenant2_user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- common_db scripts	

CREATE TABLE tenants (
  id SERIAL PRIMARY KEY,
  slug VARCHAR(255) UNIQUE NOT NULL,
  db_name VARCHAR(100) UNIQUE NOT NULL,
  db_host VARCHAR(255),
  db_username VARCHAR(100),
  db_password TEXT,
  db_port INTEGER NOT NULL DEFAULT 5432,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO tenants (slug, db_name, db_host, db_username, db_password, db_port) VALUES
  ('tenant1', 'tenant1_db', 'localhost', 'tenant1_user', 'tenant1', 5432),
  ('tenant2', 'tenant2_db', 'localhost', 'tenant2_user', 'tenant2', 5432);
  
  
  -- Select the tenant1 database.
USE tenant1_db;

CREATE TABLE users(
  id INT IDENTITY(1, 1) PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  address VARCHAR(400)
);

INSERT INTO users(first_name, last_name, email, address) VALUES
 ('John', 'Doe', 'johndoe@email.com', 'USA');

-- Select the tenant2 database.
USE tenant2_db;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  address VARCHAR(400)
);
INSERT INTO users(first_name, last_name, email) VALUES
 ('Jane', 'Doe', 'janedoe@email.com');