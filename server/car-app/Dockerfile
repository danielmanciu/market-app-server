FROM golang:1.24.4-alpine3.21

COPY . /server/car-app

WORKDIR /server/car-app

EXPOSE 2025

ENTRYPOINT ["go", "run", "main.go"]
