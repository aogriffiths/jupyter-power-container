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
Using bash or similar:
```bash
docker pull northhighland/jupyter-power-container
curl -O https://raw.githubusercontent.com/aogriffiths/jupyter-power-container/master/run.sh
./run.sh
```

## Windows
Using powershell (not cmd):
```bat
docker pull northhighland/jupyter-power-container
wget https://raw.githubusercontent.com/aogriffiths/jupyter-power-container/master/run.bat -OutFile run.bat
.\run.bat
```

### Windows Notes:
* Jupyter will suggest opening a url with the ip `0.0.0.0` but on Windows you may need to convert this to `localhost` e.g.
    ```
    from -> http://0.0.0.0:8888/?token=...
    to ---> http://localhost:8888/?token=...
    ```
* If you get `permission denied` errors when running `.\run.bat` it may be to do with docker drive mount settings. These can be reset via the windows docker setting screen and the "reset permissions" button.
* Windows and docker can also run in to problems after a system suspend or hibernate. If you're stuck a fresh reboot might help.


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
