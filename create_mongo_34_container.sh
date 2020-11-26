# [2020Oct06 MCK] created
# from: https://hub.docker.com/r/centos/mongodb-34-centos7
# [2020Oct07 JCK] various mods to permit mongorestore to run
#    and load data from hosted xfer directory.
#

# set env vars to pass into the docker container
DIR=$(dirname $0)
if [ -e "$DIR/defs.sh" ]; then
    echo "The file \"defs.sh\" exists, please remove it if okay to proceed."
    exit
fi

cat > $DIR/defs.sh <<EOD
export MONGO_VERSION=34
export MONGO_CONTAINER=mongodb\${MONGO_VERSION}
EOD

MONGOUSER=cii
PSWD=ciipassword
DB=cii-test
ADMINPSWD=adminpassword
IMAGE=centos/mongodb-34-centos7
CONTAINER_MONGO_DATA=/var/lib/mongodb/data
HOST_MONGO_DATA=/home/chris/projects/cii/mongo/mongodb34-data

CONTAINER_XFER=/var/lib/mongodb/xfer
HOST_XFER=/home/chris/projects/cii/mongo/xfer

# Mappings of volume paths and ports
PORTMAP="-p 27017:27017"

# make sure the directory exists to store these mongodb data files
for i in $HOST_MONGO_DATA $HOST_XFER; do
    mkdir -p $i
    sudo chown -R 184:997 $i
    # these do not appear to be necessary.
    #   they are required on Fedora for hosted mongo using on standard directories
    #semanage fcontext -a -t mongod_log_t $i.*
    #chcon -Rv -u system_u -t mongod_log_t $i
    #restorecon -R -v $i
done

#docker run -d -e MONGODB_USER=<user> -e MONGODB_PASSWORD=<password> -e MONGODB_DATABASE=<database> -e MONGODB_ADMIN_PASSWORD=<admin_password> -v /home/user/database:/var/lib/mongodb/data rhscl/mongodb-34-rhel7

docker run --name=mongodb34 -d\
    -e MONGODB_USER=$MONGOUSER \
    -e MONGODB_PASSWORD=$PSWD -e MONGODB_DATABASE=$DB \
    -e MONGODB_ADMIN_PASSWORD=$ADMINPSWD \
    -v $HOST_MONGO_DATA:$CONTAINER_MONGO_DATA \
    -v $HOST_XFER:$CONTAINER_XFER \
    $PORTMAP $IMAGE
