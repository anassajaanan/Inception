FROM alpine:3.19.1

WORKDIR /app

COPY project/ /app/

RUN apk update && apk add --no-cache nodejs npm

RUN npm install

EXPOSE 3000

CMD [ "node", "app.js" ]