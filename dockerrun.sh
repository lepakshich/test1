#!/bin/sh
  
cat $HOME/dockerpassword | docker login --username lepakshich --password-stdin
rv=$?
echo "login rv, $rv"

set +e
docker rm -f edureka_cert1
rv=$?
echo "rm rv, $rv"
set -e

docker pull lepakshich/test1:latest
rv=$?
echo "pull rv, $rv"

docker run -d -p 80:80 --name edureka_cert1 lepakshich/test:latest
echo "run rv, $rv"
rv=$?

exit $rv

docker push lepakshich/test:latest

docker service ps web2

if [ $? -eq 0 ]
then
        docker service update --with-registry-auth --force --update-parallelism 1 --update-delay 5s --image lepakshich/test:latest web2
else
        docker service create --with-registry-auth --replicas 2 -p 8101:80 --name web2 lepakshich/test:latest
fi

exit 0
