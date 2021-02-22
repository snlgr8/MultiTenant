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

