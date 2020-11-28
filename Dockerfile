FROM golang:1.15-alpine as builder
MAINTAINER Luc Michalski <lmichalski@evolutive-business.com>

ARG DW_QUERY_DIGEST_VERSION=${DW_QUERY_DIGEST_VERSION:-"v0.9.6"}
ARG BUILD_DATE

WORKDIR /go/src/gitlab.com/devopsworks/tools/dw-query-digest

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

# hadolint ignore=SC2016
RUN GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0 \
    go build \
        -tags release \
        -ldflags '-w -extldflags "-static" -X main.Version=${DW_QUERY_DIGEST_VERSION} -X main.BuildDate=${BUILD_DATE}' -a \
        -o /go/bin/dw-query-digest

FROM scratch

COPY --from=builder /go/bin/dw-query-digest /usr/local/bin/dw-query-digest

ENTRYPOINT ["/usr/local/bin/dw-query-digest"]
