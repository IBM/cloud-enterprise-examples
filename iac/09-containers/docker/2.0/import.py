#!/usr/bin/env python

from pymongo import MongoClient
import json
import os
import sys
import logging

logging.basicConfig(level=logging.DEBUG)

mongodb_uri = os.environ.get('APP_MONGODB_URI')
if not mongodb_uri:
    mongodb_uri = 'mongodb://localhost/moviedb'
ssl_ca_cert_path = os.environ.get('APP_SSL_CA_CERT')
if not ssl_ca_cert_path:
    port = './db_certificate.cert'
db_admin_password = os.environ.get('PASSWORD')
if not db_admin_password:
    logging.error("the environment variable PASSWORD is required")

# logging.debug('MongoDB URI: %s' % mongodb_uri)
logging.debug('SSL CA Certificate File: %s' % ssl_ca_cert_path)

mongodb_uri = mongodb_uri.replace('$PASSWORD', db_admin_password)
mongodb_uri = mongodb_uri.replace('ibmclouddb', 'moviedb')

logging.debug('MongoDB URI: %s' % mongodb_uri)

client = MongoClient(mongodb_uri,
                     ssl=True,
                     ssl_ca_certs=ssl_ca_cert_path)

dbnames = client.list_database_names()

if (len(sys.argv) > 1) and (sys.argv[1] == '-e' or sys.argv[1] == '--empty'):
    db = client['moviedb']
    movies = db['movie']
    movies.drop()
    logging.info("the movies collection has been deleted")
else:
    if not 'moviedb' in dbnames:
        db = client['moviedb']
        movies = db['movie']
        with open('/data/init/db.min.json') as f:
            data = json.load(f)
        movies.insert_many(data['movies'])
        logging.info("movies imported from /data/init/db.min.json")
    else:
        logging.info("nothing imported, movies collection already exists")

client.close()
