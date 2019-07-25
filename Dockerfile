# Copyright 2019 FairwindsOps Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.10-alpine as golang

RUN apk add -U --no-cache ca-certificates git make
WORKDIR /go/src/github.com/cristim/autospotting/
COPY autospotting/ .

# Since FLAVOR=custom we need a binary license, but we don't actually want the
#  upstream binary license
COPY autospotting/LICENSE ./BINARY_LICENSE

# The version is ${FLAVOR}-${TRAVIS_BUILD_NUMBER}
ARG TRAVIS_BUILD_NUMBER
RUN FLAVOR=fairwinds CGO_ENABLED=0 make

FROM scratch
WORKDIR /

LABEL license=Apache-2.0
LABEL maintainer=Fairwinds

COPY autospotting/LICENSE /
COPY --from=golang /go/src/github.com/cristim/autospotting/autospotting .
COPY --from=golang /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./autospotting"]
