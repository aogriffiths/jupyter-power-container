@echo off
SET CONTAINER_NAME=jupyter-power-container
SET CONTAINER_IDS=$(docker ps -a -q --filter=ancestor=northhighland/jupyter-power-container:latest --format="{{.ID}}")
if [  -n "$CONTAINER_IDS" ]
then
  echo "stoping jupyter-power-container docker containers:"
  docker stop $CONTAINER_IDS
else
  echo "no jupyter-power-containers to stop."
fi
