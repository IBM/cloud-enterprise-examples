import json
import unittest
from app import app, db


class BaseCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.db = db.get_db()

    def tearDown(self):
        for collection in self.db.list_collection_names():
            self.db.drop_collection(collection)


class TestCreateMovie(BaseCase):
    def test_successful_add(self):
        movie_payload = {
            "title": "The Hidden Fortress",
            "titleSort": "Hidden Fortress",
            "originalTitle": "隠し砦の三悪人",
            "contentRating": "Not Rated",
            "summary": "Lured by gold, two greedy peasants escort a man and woman across enemy lines. However, they do not realize that their companions are actually a princess and her general.",
            "rating": 10.0,
            "audienceRating": 9.3,
            "year": 1958,
            "duration": 8318805,
            "originallyAvailableAt": "1958-12-28",
            "addedAt": 1333272650,
            "updatedAt": 1546859058,
            "audienceRatingImage": "rottentomatoes://image.rating.upright",
            "hasPremiumPrimaryExtra": 1,
            "ratingImage": "rottentomatoes://image.rating.ripe",
            "genre": "Drama",
            "director": ["Akira Kurosawa"],
            "writer": ["Akira Kurosawa", "Hideo Oguni"],
            "country": "Japan",
            "cast": ["Toshirô Mifune", "Takashi Shimura", "Minoru Chiaki"]
        }
        response = self.app.post('/api/movies',
                                 headers={"Content-Type": "application/json"},
                                 data=json.dumps(movie_payload),
                                 )
        self.assertEqual(str, type(response.json['id']))
        self.assertEqual(200, response.status_code)


class TestGetMovies(BaseCase):
    def test_empty_response(self):
        response = self.app.get('/api/movies')
        self.assertListEqual(response.json, [])
        self.assertEqual(response.status_code, 200)

    def test_movie_response(self):
        movie_payload = {
            "title": "Ikiru",
            "originalTitle": "生きる",
            "contentRating": "Not Rated",
            "summary": "Kanji Watanabe is a middle-aged man who has worked in the same monotonous bureaucratic position for decades. Learning he has cancer, he starts to look for the meaning of his life.",
            "rating": 8.3,
            "year": 1952,
            "tagline": "One of the Great Films of Our Time!",
            "duration": 8609173,
            "originallyAvailableAt": "1952-10-09",
            "addedAt": 1333349868,
            "updatedAt": 1546859687,
            "hasPremiumPrimaryExtra": 1,
            "ratingImage": "imdb://image.rating",
            "genre": "Drama",
            "director": ["Akira Kurosawa"],
            "writer": ["Shinobu Hashimoto", "Akira Kurosawa"],
            "country": "Japan",
            "cast": ["Takashi Shimura", "Shinichi Himori", "Haruo Tanaka"]
        }
        response = self.app.post('/api/movies',
                                 headers={"Content-Type": "application/json"},
                                 data=json.dumps(movie_payload),
                                 )
        response = self.app.get('/api/movies')
        added_movie = response.json[0]

        for key in movie_payload:
            self.assertEqual(movie_payload[key], added_movie[key])
        self.assertEqual(200, response.status_code)


if __name__ == '__main__':
    unittest.main()
