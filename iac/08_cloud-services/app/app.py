from flask import Flask, Response, request
from flask_restful import Api, Resource
from flask_mongoengine import MongoEngine
from datetime import datetime
import json
import os

mongodb_uri = os.environ.get('APP_MONGODB_URI')
if not mongodb_uri:
    mongodb_uri = 'mongodb://localhost/moviedb'
port = os.environ.get('APP_PORT')
if not port:
    port = '8080'

app = Flask(__name__)
app.config['MONGODB_SETTINGS'] = {'host': mongodb_uri}
api = Api(app)

print(app.config)

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
        movies = Movie.objects().to_json()
        return Response(movies, mimetype="application/json", status=200)

    def post(self):
        body = request.get_json()
        movie = Movie(**body).save()
        id = movie.id
        return {'id': str(id)}, 200


class MovieApi(Resource):
    def put(self, id):
        body = request.get_json()
        Movie.objects.get(id=id).update(**body)
        return '', 200

    def delete(self, id):
        Movie.objects.get(id=id).delete()
        return '', 200

    def get(self, id):
        movie = Movie.objects.get(id=id).to_json()
        return Response(movie, mimetype="application/json", status=200)


api.add_resource(MoviesApi, '/api/movies')
api.add_resource(MovieApi, '/api/movies/<id>')

app.run(host='0.0.0.0', port=port)
