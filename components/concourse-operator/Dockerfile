# Build the manager binary
FROM golang:1.11 as builder
WORKDIR /go/src/github.com/alphagov/gsp/components/concourse-operator
COPY pkg/    pkg/
COPY cmd/    cmd/
COPY vendor/ vendor/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o manager github.com/alphagov/gsp/components/concourse-operator/cmd/manager

# CA certs
FROM alpine:3.2 as certs
RUN apk add ca-certificates --update

# Minimal image for controller
FROM alpine:3.2
WORKDIR /root/
COPY --from=builder /go/src/github.com/alphagov/gsp/components/concourse-operator/manager /manager
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["/manager"]
