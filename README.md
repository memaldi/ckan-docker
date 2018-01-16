# CKAN docker images

This repository contains Dockerfiles for creating a [CKAN](http://ckan.org) instance. You can find Dockerfiles at [memaldi/ckan-docker](https://github.com/memaldi/ckan-docker) repository.

### Launch redis instance

```
$ docker run -d --network ckan --name ckan-redis redis:3-alpine
```

### Build and lauch postgres instance

**NOTE**: At this time, ckan_default user password must be manually modified at `postgres/datastore.sh`.

```
#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE DATABASE ckan_default;
 	CREATE USER ckan_default WITH LOGIN PASSWORD '<ckan_default>';
  GRANT ALL PRIVILEGES ON DATABASE ckan_default TO ckan_default ;
EOSQL
```

Build and launch the image from repository.

```
$ cd postgres
$ docker build -t memaldi/ckan-postgres .
$ docker run --name ckan-db --network ckan -e POSTGRES_PASSWORD=ckan-postgres -d memaldi/ckan-postgres
```

### Lauch solr instance

```
$ docker run -ti --name ckan-solr --network ckan memaldi/ckan-solr solr-create -c ckan -d /conf
```
Alternatively, you can build image from [memaldi/ckan-docker](https://github.com/memaldi/ckan-docker) repository.

```
$ cd solr
$ docker build -t memaldi/ckan-solr .
```

### Build and launch CKAN instance

Modify database settings at `ckan/production.ini` file:

```
## Database Settings
sqlalchemy.url = postgresql://ckan_default:ckan_default@ckan-db/ckan_default
```

Build and launch CKAN instance:

```
$ cd ckan
$ docker build -t memaldi/ckan .
$ docker run -d --network ckan --name ckan -p 80:5000 memaldi/ckan:2.7.2
```

### Create an admin CKAN user

```
$ docker exec -ti memaldi/ckan /bin/bash
$ paster sysadmin add admin email=admin@admin.org name=admin -c /etc/ckan/default/production.ini
```
