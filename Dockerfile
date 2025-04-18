#--- Build stage
FROM golang:1.21-bullseye AS go-builder

WORKDIR /src

COPY . /src/

RUN make build CGO_ENABLED=0

#--- Image stage
FROM alpine:3.19.1

COPY --from=go-builder /src/target/template-go /usr/bin/template-go

WORKDIR /opt

ENTRYPOINT ["/usr/bin/template-go"]
