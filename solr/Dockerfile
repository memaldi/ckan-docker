FROM solr:6.6.5

USER root

RUN mkdir -p /opt/solr/server/solr/ckan/conf
RUN mkdir -p /opt/solr/server/solr/ckan/data
RUN echo name=ckan > /opt/solr/server/solr/ckan/core.properties

COPY ckan /opt/solr/server/solr/ckan/conf
RUN chmod -R a+rwx /opt/solr/

USER $SOLR_USER:$SOLR_USER
