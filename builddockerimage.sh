#!/bin/sh
  
#use Dockerfile
docker build -t lepakshich/test:latest .

#push to Docker hub
docker push lepakshich/test:latest

exit 0
