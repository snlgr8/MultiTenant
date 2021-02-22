DROP DATABASE common_db;

CREATE USER common_db_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION;



CREATE DATABASE common_db
    WITH 
    OWNER = common_db_user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


 GRANT ALL PRIVILEGES ON DATABASE common_db to common_db_user;


 