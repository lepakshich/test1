#!/bin/sh
  
cat $HOME/dockerpassword | docker login --username lepakshich --password-stdin
rv=$?
echo "login rv, $rv"

set +e
docker rm -f edureka_cert1
rv=$?
echo "rm rv, $rv"
set -e

docker pull lepakshich/test:latest
rv=$?
echo "pull rv, $rv"

docker run -d -p 80:80 --name edureka_cert1 lepakshich/test:latest
echo "run rv, $rv"
rv=$?

exit $rv
