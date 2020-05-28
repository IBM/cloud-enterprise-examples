from pymongo import MongoClient
import json
import os

mongodb_uri = os.environ.get('APP_MONGODB_URI')
if not mongodb_uri:
    mongodb_uri = 'mongodb://localhost/moviedb'

client = MongoClient(mongodb_uri)
dbnames = client.list_database_names()

if not 'moviedb' in dbnames:
    db = client['moviedb']
    movies = db['movie']
    with open('./db.json') as f:
        data = json.load(f)
    movies.insert_many(data['movies'])

client.close()
