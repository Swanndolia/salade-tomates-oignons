#bin/bash
docker-compose down --volume
docker image rm $(docker images)
ndocker container prune -f
git pull
