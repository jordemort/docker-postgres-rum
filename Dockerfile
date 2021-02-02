FROM postgres:13 AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential postgresql-server-dev-13

COPY rum/ /usr/src/rum/

WORKDIR /usr/src/rum/

RUN make USE_PGXS=1 && \
    make USE_PGXS=1 DESTDIR=/tmp/build install

FROM postgres:13 AS runtime
COPY --from=build /tmp/build/ /
