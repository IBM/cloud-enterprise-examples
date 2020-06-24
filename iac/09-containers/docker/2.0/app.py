from flask import Flask, Response, request
from flask_restful import Api, Resource
from flask_mongoengine import MongoEngine
from datetime import datetime
import json
import os
import logging
import ssl

logging.basicConfig(level=logging.DEBUG)

mongodb_uri = os.environ.get('APP_MONGODB_URI')
if not mongodb_uri:
    mongodb_uri = 'mongodb://localhost/moviedb'
port = os.environ.get('APP_PORT')
if not port:
    port = '8080'
ssl_ca_cert_path = os.environ.get('APP_SSL_CA_CERT')
if not ssl_ca_cert_path:
    port = '/app/db_certificate.cert'
db_admin_password = os.environ.get('PASSWORD')
if not db_admin_password:
    logging.error(
        "Password not set, the environment variable PASSWORD is required")

logging.debug('MongoDB URI: %s' % mongodb_uri)
logging.debug('Port: %s' % port)
logging.debug('SSL CA Certificate File: %s' % ssl_ca_cert_path)

mongodb_uri = mongodb_uri.replace('$PASSWORD', db_admin_password)
mongodb_uri = mongodb_uri.replace('ibmclouddb', 'moviedb')

app = Flask(__name__)
app.config['MONGODB_SETTINGS'] = {
    'MONGODB_HOST': mongodb_uri,
    'MONGODB_DB': 'moviedb',
    'MONGODB_SSL': True,
    'MONGODB_SSL_CERT_REQS': ssl.CERT_REQUIRED,
    'MONGODB_SSL_CA_CERTS': ssl_ca_cert_path
}
api = Api(app)

db = MongoEngine()
db.init_app(app)


class Movie(db.Document):
    title = db.StringField(required=True)
    titleSort = db.StringField()
    originalTitle = db.StringField()
    contentRating = db.StringField()
    rating = db.FloatField()
    ratingImage = db.StringField()
    audienceRating = db.FloatField()
    audienceRatingImage = db.StringField()
    hasPremiumPrimaryExtra = db.IntField()
    summary = db.StringField(required=False)
    year = db.IntField(required=False)
    tagline = db.StringField()
    duration = db.IntField(required=False)
    originallyAvailableAt = db.StringField(required=False)
    addedAt = db.IntField(
        default=datetime.timestamp(datetime.now()), required=False)
    updatedAt = db.IntField(
        default=datetime.timestamp(datetime.now()), required=False)
    genre = db.StringField(required=True)
    # genre = db.ListField(required=True)
    director = db.ListField(db.StringField(), required=True)
    writer = db.ListField(db.StringField(), required=False)
    country = db.StringField(required=False)
    cast = db.ListField(db.StringField(), required=True)


class MoviesApi(Resource):
    def get(self):
        logging.info('getting all movies')
        movies = Movie.objects().to_json()
        return Response(movies, mimetype="application/json", status=200)

    def post(self):
        body = request.get_json()
        movie = Movie(**body).save()
        id = movie.id
        logging.info('adding a new movie with ID=%s' % id)
        return {'id': str(id)}, 200


class MovieApi(Resource):
    def put(self, id):
        logging.info('updating the movie with ID=%s' % id)
        body = request.get_json()
        Movie.objects.get(id=id).update(**body)
        return '', 200

    def delete(self, id):
        logging.info('deleting the movie with ID=%s' % id)
        Movie.objects.get(id=id).delete()
        return '', 200

    def get(self, id):
        logging.info('getting the movie with ID=%s' % id)
        movie = Movie.objects.get(id=id).to_json()
        return Response(movie, mimetype="application/json", status=200)


api.add_resource(MoviesApi, '/api/movies')
api.add_resource(MovieApi, '/api/movies/<id>')


@app.route('/api/healthcheck')
def health_check():
    logging.info('checking health')
    return {'HealthCheckResponse': True}


app.run(host='0.0.0.0', port=port)
