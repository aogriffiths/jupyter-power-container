Power Jupyter Container
=======================

An veritable kitchen sink of things you can do with Jupyter notebooks. Like:

* **Ju**lia, **Pyt**hon and **R** - the three kernels, which **JuPyt**e**R** gets it's name from.
* Javascript, Bash and Ruby - a few more handy kernels.
* docker, gnugpg

Modules and packages:

* **Julia:** IJulia, Gadfly, RDatasets, HDF5, TensorFlow.
* **Python:** numpy, scipy, pandas, ipython, jupyter_contrib_nbextensions,
jupyter_nbextensions_configurator, matplotlib, seaborn, plotly, scikit-learn,
scikit-image, sympy, pytest, cython, patsy, statsmodels, cloudpickle, dill,
numba, bokeh, RISE, html5lib, simplecrypt, python-gnupg, qgrid.
* **R**: TBC

Usage
=====

This is the quick way; it requires:
* docker
* a shell (like bash on linux/max or powershell on Windows)

## Mac or Linux
Set up with bash or similar:
```bash
docker pull northhighland/jupyter-power-container
curl -O https://raw.githubusercontent.com/aogriffiths/jupyter-power-container/master/start.sh
curl -O https://raw.githubusercontent.com/aogriffiths/jupyter-power-container/master/stop.sh
```

Then you can run stop and start e.g.:
```bash
$ ./start.sh
docker container id:
c229f724d6095d8b0105f06230e99f208c00c61a9620805efe30b0c482fec4af

URL:
http://0.0.0.0:8888/?token=lXXKM43j0nxitMzElSl22QecsE1T6z0E

$ ./stop.sh
stoping jupyter-power-container docker containers:
c229f724d609
```

See general notes below.

## Windows
Using powershell (not cmd):
```PowerShell
docker pull northhighland/jupyter-power-container
wget https://raw.githubusercontent.com/aogriffiths/jupyter-power-container/master/start.bat -OutFile start.bat
.\start.bat
```

See Windows specific and general notes below.

### Windows Notes:
* For `permission denied` errors when running `.\start.bat` it may be to do with docker drive mount settings. These can be reset via the windows docker setting screen and the "reset permissions" button.
* For `Error starting userland proxy` errors try
    * stoping and deleting all running containers with
      ```
      docker stop $(docker ps -a -q)
      docker rm $(docker ps -a -q)
      ```
      ; and if that doesn't work try
    * restarting docker with
      ```
      restart-service *docker*
      ```
      ; and if that doesn't work try
    * restarting your computer with
      ```
      Restart-Computer
      ```
* Windows and docker can also run in to problems after a system suspend or hibernate. If you're stuck a restarting your computer might help with this.

## General Notes

* If you haven't guessed already you access Jupyter though your browser with the URL given after running `start.bat` or `start.sh`, e.g. `http://0.0.0.0:8888/?token=lXXKM43j0nxitMzElSl22QecsE1T6z0E`.
* Any files you create in Jupyter will be stored on your local machine under `$HOME\jupyter-power-container-home`.

Examples
========

Some example data can be found [here](https://github.com/nickvdata/NH-sample-data-analysis). You can get it with:

```
cd $HOME/jupyter-power-container-home
git clone https://github.com/nickvdata/NH-sample-data-analysis
```

Then, in Jupyter you can play with it by going to the `NH-sample-data-analysis` directory and opening the relevant notebooks.

Architecture
============



Building
========

This takes longer; it requires:
* docker
* make
* git
* a shell (like bash on linux/max or powershell on Windows)


## Mac or Linux
Using bash or similar:
```bash
git clone https://github.com/aogriffiths/jupyter-power-container
make build
make serve
```

## Windows
The steps should be similar on Windows but have not been tested.

## Windows and Mac Notes
* `make build` - builds the power container image
* `make serve` - runs a Jupyter notebooks webserver using the image
* `make shell` - start a shell, for you to poke arround in, using the image




See Also
========
* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [Datascience notebook](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook)
* [Jupyter notebook tips tricks](https://www.dataquest.io/blog/jupyter-notebook-tips-tricks-shortcuts/)
