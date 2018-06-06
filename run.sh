CONTAINER_NAME=jupyter-power-container
HOME_DIR=$HOME/$CONTAINER_NAME-home
mkdir -p $HOME_DIR

docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add 50 \
  -v $HOME_DIR:/home/poweruser \
  -p 8888:8888 \
  $CONTAINER_NAME:latest \
  jupyter notebook --ip=0.0.0.0
