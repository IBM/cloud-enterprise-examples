FROM node:13

RUN npm install -g json-server
ADD entrypoint.sh /entrypoint.sh

WORKDIR /app
VOLUME /data

EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "" ]
