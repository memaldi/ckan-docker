psql -c "create user ckan_default with login password 'ckan_default';";
createdb -O ckan_default ckan_default -E utf-8;
