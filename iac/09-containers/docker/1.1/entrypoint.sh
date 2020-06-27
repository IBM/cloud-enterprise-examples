#!/bin/bash

if [[ -n "$@" ]]; then
  exec "$@"
  exit $?
fi

port="8080"
host="0.0.0.0"
init_db='{"movies": []}'
init_db_file=/data/init/db.min.json
db_file=/data/db.json

init_database() {
  # If the DB is there and contain movies, there is nothing to do
  [[ -e $db_file ]] && grep -q '"movies"' $db_file && echo "A database file with movies already exists." && return

  # If the init DB file is there, copy it to the DB file and return if succeed
  [[ -e $init_db_file ]] && cp $init_db_file $db_file && echo "initialized the database with the database file $init_db_file." && return

  # if everything failed, initiallize the DB with empty list of movies
  echo "initializing the database with an empty database."
  echo $init_db > $db_file
}

init_database

echo "Starting json-server on $host:$port watching for DB file $db_file"
json-server --port $port --host $host --watch $db_file
