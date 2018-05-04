SET CONTAINER_NAME=jupyter-power-container
SET HOME_DIR=%userprofile%\%CONTAINER_NAME%-home

docker run --rm -it ^
   -v /var/run/docker.sock:/var/run/docker.sock ^
   --group-add 50 ^
   -v %HOME_DIR%:/home/poweruser ^
   -p 8888:8888 ^
   northhighland/jupyter-power-container:latest ^
   jupyter notebook --ip=0.0.0.0
