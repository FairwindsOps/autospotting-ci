FROM golang:1.10-alpine as golang
RUN apk add -U --no-cache ca-certificates git make
WORKDIR /go/src/github.com/cristim/autospotting/
COPY autospotting/ .
# Since FLAVOR=custom we need a binary license, but we don't actually want the
#  upstream binary license
COPY autospotting/LICENSE ./BINARY_LICENSE
# The version is ${FLAVOR}-${TRAVIS_BUILD_NUMBER} ${FLAVOR}-${SHA} if no build number is set
ARG TRAVIS_BUILD_NUMBER
ARG SHA
RUN FLAVOR=reactiveops CGO_ENABLED=0 make

FROM scratch
WORKDIR /
COPY autospotting/LICENSE /
COPY --from=golang /go/src/github.com/cristim/autospotting/autospotting .
COPY --from=golang /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./autospotting"]
