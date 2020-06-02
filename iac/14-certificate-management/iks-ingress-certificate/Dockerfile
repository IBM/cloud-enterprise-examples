FROM node:14

RUN npm install -g json-server

COPY data/db.min.json /data/db.min.json

EXPOSE 8080

CMD [ "json-server", "--watch", "/data/db.min.json", "--port", "8080", "--host", "0.0.0.0" ]
