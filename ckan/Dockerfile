FROM ubuntu

RUN apt-get update && apt-get install -y python-dev python-pip python-virtualenv git postgresql-server-dev-9.5
# RUN apk update && apk add python-dev libpq py-pip py-virtualenv git postgresql-dev gcc musl-dev libmagic

RUN pip install -U pip
RUN pip install setuptools==36.1
RUN pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.7.2#egg=ckan'
RUN pip install -r /src/ckan/requirements.txt

COPY production.ini /etc/ckan/default/production.ini

RUN ln -s /src/ckan/who.ini /etc/ckan/default/who.ini

COPY entrypoint.sh /entrypoint.sh
