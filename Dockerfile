ARG PG_MAJOR=9.6
ARG PGHOME=/var/lib/postgresql
ARG PGDATA=$PGHOME/data

FROM postgres:$PG_MAJOR

ENV PGDATA=$PGDATA PATH=$PATH:$PGBIN

WORKDIR $PGHOME

RUN apt-get update \
 && apt-get install -y python3-pip \
 && pip3 install psycopg2-binary patroni[consul] \
 && mkdir -p "$PGDATA" \
 && chmod -R 700 "$PGDATA"

USER postgres

CMD ["patroni", "/postgres.yml"]
