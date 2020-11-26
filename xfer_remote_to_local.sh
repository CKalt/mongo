#!/bin/sh
. ./defs.sh

sudo rm -rf xfer/*
sudo mongodump --host 172.28.2.93 -d cii2Test --port 31020 --username admin --password VkcGAgeG0PynWnAqUT00 --authenticationDatabase admin --out ./xfer

docker exec -ti ${MONGO_CONTAINER} \
    /bin/sh -c "/opt/rh/rh-mongodb${MONGO_VERSION}/root/usr/bin/mongorestore --noIndexRestore --username admin --password adminpassword /var/lib/mongodb/xfer/ --drop"

