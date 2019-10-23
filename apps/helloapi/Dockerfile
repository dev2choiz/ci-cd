FROM golang:latest as helloapi_base
WORKDIR /helloapi

FROM helloapi_base as helloapi_dev
CMD ["go", "run", "main.go"]

FROM helloapi_base as helloapi_builder
COPY . /helloapi
RUN go mod vendor
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main

FROM scratch as helloapi_release
WORKDIR /app
COPY --from=helloapi_builder /helloapi/main .
CMD ["./main"]
