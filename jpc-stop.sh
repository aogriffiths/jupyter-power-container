CONTAINER_NAME=jupyter-power-container
CONTAINER_IDS=$(docker ps -a -q --filter ancestor=$CONTAINER_NAME --format="{{.ID}}")
if [  -n "$CONTAINER_IDS" ]
then
  echo "stoping jupyter-power-container docker containers:"
  docker stop $CONTAINER_IDS
else
  echo "no jupyter-power-containers to stop."
fi
