#!/bin/sh
DIR=$(dirname $0)
if [ ! -e "$DIR/defs.sh" ]; then
    echo "The file \"$DIR/defs.sh\" does not exist."
    exit
fi

. $DIR/defs.sh

docker container stop ${MONGO_CONTAINER}
docker container rm ${MONGO_CONTAINER}

sudo rm -rf xfer mongodb${MONGO_VERSION}-data
rm $DIR/defs.sh
