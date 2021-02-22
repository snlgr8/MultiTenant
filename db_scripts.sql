-- https://blog.lftechnology.com/designing-a-secure-and-scalable-multi-tenant-application-on-node-js-15ae13dda778
-- DB scripts 
DROP DATABASE common_db;

DROP DATABASE tenant1_db;

DROP DATABASE tenant2_db;

DROP USER common_db_user;

DROP USER tenant1_user;

DROP USER tenant2_user;


CREATE USER common_db_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION;
  
  
-- User: tenant1_user

CREATE USER tenant1_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;
  
  

CREATE USER tenant2_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;


-- Database: common_db


CREATE DATABASE common_db
    WITH 
    OWNER = common_db_user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	


CREATE DATABASE tenant1_db
    WITH 
    OWNER = tenant1_user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


CREATE DATABASE tenant2_db
    WITH 
    OWNER = tenant2_user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
 GRANT ALL PRIVILEGES ON DATABASE tenant1_db to tenant1_user;

 GRANT ALL PRIVILEGES ON DATABASE common_db to common_db_user;

 GRANT ALL PRIVILEGES ON DATABASE tenant2_db to tenant2_user;

