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

RUN git clone https://user:$git_pass@gitlab.com/will.wang1/hotrod-base

RUN mkdir hotrod-route
COPY cmd/ hotrod-route/cmd/
COPY route/ hotrod-route/route/
COPY vendor/ hotrod-route/vendor/
COPY main.go hotrod-route/

WORKDIR /go/src/gitlab.com/kelda-hotrod/hotrod-route

RUN go build -o hotrod main.go 
RUN mv hotrod /go/bin/

ENTRYPOINT ["/go/bin/hotrod", "route"]

