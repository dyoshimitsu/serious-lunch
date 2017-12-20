#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

sudo chmod a+wt /var/run/mysqld

docker run -d --name mysql \
    --tmpfs /var/lib/mysql \
    -v "/var/run/mysqld:/var/run/mysqld" \
    -v "${SCRIPT_DIR}/db/mysql-initdb.d:/docker-entrypoint-initdb.d" \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -p 3306:3306 \
    mysql:5.7.20
