FROM postgres:14 AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential postgresql-server-dev-14

COPY rum/ /usr/src/rum/

WORKDIR /usr/src/rum/

RUN make USE_PGXS=1 && \
    make USE_PGXS=1 DESTDIR=/tmp/build install

FROM postgres:14 AS runtime
COPY --from=build /tmp/build/ /
