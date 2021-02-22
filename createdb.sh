pwd
psql -U postgres << EOF
\i db_scripts.sql
\q
EOF
psql -U common_db_user -d common_db <<EOF
\i create_common_db.sql
\q 
EOF
psql -U tenant1_user -d tenant1_db <<EOF
\i create_tenant1_db.sql
\q
EOF
psql -U tenant2_user -d tenant2_db <<EOF
\i create_tenant2_db.sql
\q
EOF