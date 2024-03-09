FROM alpine:3.19.1

WORKDIR /app

RUN apk update && apk add --no-cache python3

COPY files/ /app/

EXPOSE 80

CMD ["python3", "-m", "http.server", "80"]