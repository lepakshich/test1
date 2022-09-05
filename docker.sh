#!/bin/sh
  
docker build -t lepakshich/test:latest .

docker push lepakshich/test:latest

docker service ps web2

if [ $? -eq 0 ]
then
        docker service update --with-registry-auth --force --update-parallelism 1 --update-delay 5s --image lepakshich/test:latest web2
else
        docker service create --with-registry-auth --replicas 2 -p 8101:80 --name web2 lepakshich/test:latest
fi

exit 0