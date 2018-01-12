docker run -d --network ckan --name ckan-redis redis:3-alpine
docker run --name ckan-db --network ckan -e POSTGRES_PASSWORD=ckan-postgres -d memaldi/ckan-postgres
docker run -ti --name ckan-solr --network ckan memaldi/ckan-solr solr-create -c ckan -d /conf
docker run -d --network ckan --name ckan -p 80:5000 memaldi/ckan:2.7.2
