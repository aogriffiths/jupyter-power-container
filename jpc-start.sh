CONTAINER_NAME=jupyter-power-container
HOME_DIR=$HOME/$CONTAINER_NAME-home
mkdir -p $HOME_DIR
TOKEN=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

echo "docker container id:"
docker run --rm -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add 50 \
  -v $HOME_DIR:/home/poweruser \
  -p 8888:8888 \
  $CONTAINER_NAME:latest \
  jupyter notebook --ip=0.0.0.0 --NotebookApp.token=$TOKEN

echo ""
echo "URL:"
echo "http://0.0.0.0:8888/?token="$TOKEN
