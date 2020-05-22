FROM node:13

RUN npm install -g json-server

WORKDIR /app
VOLUME /data

EXPOSE 8080

CMD [ "json-server", "--watch", "/data/db.min.json", "--port", "8080", "--host", "0.0.0.0" ]
