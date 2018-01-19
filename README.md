# CKAN docker images

This repository contains Dockerfiles for creating a [CKAN](http://ckan.org) instance. You can find Dockerfiles at [memaldi/ckan-docker](https://github.com/memaldi/ckan-docker) repository.

### Launch redis instance

```
$ docker run -d --network ckan --name ckan-redis redis:3-alpine
```

### Lauch postgres instance

Launch a postgres container.

```
$ docker run --name ckan-db --network ckan -e POSTGRES_PASSWORD=ckan-postgres -d postgres
```

Create CKAN databases and user:

```
$ docker exec -ti ckan-db /bin/bash
$ su postgres
$ psql
$ CREATE DATABASE ckan_default;
$ CREATE USER ckan_default WITH LOGIN PASSWORD '<ckan_default_password>';
$ GRANT ALL PRIVILEGES ON DATABASE ckan_default TO ckan_default ;
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

### Launch CKAN instance

Use [Environment Variables supported by CKAN](http://docs.ckan.org/en/ckan-2.7.2/maintaining/configuration.html#ckan-configuration-file) for customizing your \*.ini file.
The following ones are mandatory: `CKAN_SQLALCHEMY_URL`, `CKAN_SOLR_URL`, `CKAN_REDIS_URL`, `CKAN_SITE_URL` and `CKAN_STORAGE_PATH`.

It's highly recommended to create a volume at `CKAN_STORAGE_PATH` dir, in which resources are stored.

```
$ docker run -d --network ckan --name ckan -p 80:5000 -e CKAN_SQLALCHEMY_URL=postgresql://<ckan_db_user>:<ckan_db_password>@ckan-db/<ckan_db_name> -e CKAN_SOLR_URL=http://ckan-solr:8983/solr/ckan -e CKAN_REDIS_URL=redis://ckan-redis:6379/0 -e CKAN_SITE_URL=http://localhost -e CKAN_STORAGE_PATH=/var/lib/ckan -v <host_data_dir>:/var/lib/ckan memaldi/ckan
```

Alternatively, you can build image from [memaldi/ckan-docker](https://github.com/memaldi/ckan-docker) repository.

```
$ cd ckan
$ docker build -t memaldi/ckan:2.7.2 .
```

### Create an admin CKAN user

```
$ docker exec -ti ckan /bin/bash
$ paster sysadmin add admin email=admin@admin.org name=admin -c /etc/ckan/default/production.ini
```
