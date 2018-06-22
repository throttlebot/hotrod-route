FROM golang:1.8
MAINTAINER Hantao Wang

EXPOSE 8083

RUN mkdir -p /go/src/gitlab.com/kelda-hotrod
RUN mkdir -p /go/bin
RUN go get github.com/go-redis/redis
RUN go get github.com/lib/pq
RUN go get github.com/sirupsen/logrus

WORKDIR /go/src/gitlab.com/kelda-hotrod

ARG git_pass
ARG build_time

RUN git clone https://user:$git_pass@gitlab.com/kelda-hotrod/hotrod-base
RUN git clone https://user:$git_pass@gitlab.com/kelda-hotrod/hotrod-route

WORKDIR /go/src/gitlab.com/kelda-hotrod/hotrod-route

RUN go build -o hotrod main.go 
RUN mv hotrod /go/bin/

ENTRYPOINT ["/go/bin/hotrod", "route"]

