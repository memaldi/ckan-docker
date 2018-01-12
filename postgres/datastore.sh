#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE DATABASE ckan_default;
 	CREATE USER ckan_default WITH LOGIN PASSWORD 'ckan_default';
  GRANT ALL PRIVILEGES ON DATABASE ckan_default TO ckan_default ;
EOSQL
