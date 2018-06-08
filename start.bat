$CONTAINER_NAME="jupyter-power-container"
$HOME_DIR="$env:USERPROFILE\$CONTAINER_NAME-home"
New-Item -ItemType Directory -Force -Path $HOME_DIR
$TOKEN=(-join ((65..90) + (97..122) | Get-Random -Count 32 | % {[char]$_}))

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
echo "http://localhost:8888/?token=$TOKEN"
