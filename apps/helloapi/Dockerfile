FROM golang:latest as helloapi_base
ARG HOST_UID
ARG HOST_GID
RUN groupadd --gid $HOST_GID helloapi
RUN useradd --uid $HOST_UID --gid $HOST_GID -ms /bin/bash helloapi
USER helloapi
WORKDIR /helloapi

FROM helloapi_base as helloapi_dev
RUN go get github.com/t-yuki/gocover-cobertura
RUN go get github.com/stretchr/testify
CMD ["go", "run", "main.go"]

FROM helloapi_base as helloapi_builder
COPY --chown=helloapi:helloapi . /helloapi
USER root
RUN go mod vendor
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main
RUN chown -R helloapi:helloapi ./vendor main
USER helloapi

FROM scratch as helloapi_release
COPY --from=helloapi_builder /helloapi/main .
CMD ["./main"]
