################################################################################
# build
################################################################################

FROM golang:1.13.5 AS build
COPY . /go/src/github.com/sorintlab/stolon
WORKDIR /go/src/github.com/sorintlab/stolon

# If we're running goreleaser, then our binaries will already be copied into our
# work directory. Otherwise we should build them.
RUN set -x \
      && \
      if [ ! -f stolonctl ]; then \
        ./build; \
        mv -v bin/* ./; \
      fi

################################################################################
# release
################################################################################

FROM ubuntu:18.04 AS release
RUN set -x \
      && apt-get update -y \
      && apt-get install -y curl gpg \
      && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main\ndeb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg 11" > /etc/apt/sources.list.d/pgdg.list' \
      && curl --silent https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
      && apt-get update -y \
      && apt-get install -y software-properties-common pgbouncer postgresql-client \
      && mkdir -pv /var/run/postgresql /var/log/postgresql

COPY --from=build /go/src/github.com/sorintlab/stolon/stolon* /usr/local/bin/
USER postgres
