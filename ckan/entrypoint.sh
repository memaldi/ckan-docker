#!/bin/sh

cd /src/ckan

paster db init -c /etc/ckan/default/production.ini
