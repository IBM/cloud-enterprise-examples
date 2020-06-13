from pymongo import MongoClient
import json
import os

mongodb_uri = os.environ.get('APP_MONGODB_URI')

client = MongoClient(mongodb_uri,
                     ssl=True,
                     ssl_ca_certs="./db_ca.crt")

dbnames = client.list_database_names()

db = client['demodb']
books = db['books']

if not books.find_one():
    with open('./db.json') as f:
        data = json.load(f)
    books.insert_many(data['books'])

new_book = {
    "isbn": "9781449325862",
    "title": "Git Pocket Guide",
    "subtitle": "A Working Introduction",
    "author": "Richard E. Silverman",
    "published": "2013-08-02T00:00:00.000Z",
    "publisher": "O'Reilly Media",
    "pages": 234,
    "description": "This pocket guide is the perfect on-the-job companion to Git, the distributed version control system. It provides a compact, readable introduction to Git for new users, as well as a reference to common commands and procedures for those of you with Git experience.",
    "website": "http://chimera.labs.oreilly.com/books/1230000000561/index.html"
}

if books.count_documents({"isbn": new_book['isbn']}) == 0:
    book = books.insert_one(new_book)
    print("The new book has been inserted. ID = ", book.inserted_id)

print("Books:")
for book in books.find({}, {"title": 1}):
    print("\t", book)

query = {"publisher": "O'Reilly Media"}
print("O'Reilly Media's Books:")
for book in books.find(query, {"title": 1, "publisher": 1}):
    print("\t", book)

client.close()
