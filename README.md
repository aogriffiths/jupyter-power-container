Power Jupyter Container
=======================

An veritable kitchen sink of things you can do with Jupyter notebooks. Like:

* **JU**lia, **PYT**hon and **R** - The obvious three kernels, which **JUPYT**e**R** gets it's name from.
* Javascript, Bash and Ruby - A few more handy kernels.
* docker, gnugpg

Modules and packages:

* **Julia:** IJulia, Gadfly, RDatasets, HDF5, TensorFlow.
* **Python:** numpy, scipy, pandas, ipython, jupyter_contrib_nbextensions,
jupyter_nbextensions_configurator, matplotlib, seaborn, plotly, scikit-learn,
scikit-image, sympy, pytest, cython, patsy, statsmodels, cloudpickle, dill,
numba, bokeh, RISE, html5lib, simplecrypt, python-gnupg, qgrid.
* **R**: TBC

How to Use
==========

This is the quick way.

Requirements:
* docker

Mac Steps (Bash or similar):
```bash
docker pull northhighland/jupyter-power-container
curl -O https://raw.githubusercontent.com/aogriffiths/jupyter-power-container/master/run.sh
./run.sh
```

Windows Steps (Powershell):
```powershell
docker pull northhighland/jupyter-power-container
wget https://raw.githubusercontent.com/aogriffiths/jupyter-power-container/master/run.bat -OutFile run.bat
./run.bat
```

How to Make
===========

This may take some time!

Requirements:
* docker
* make
* git

Steps:
```bash
git clone https://github.com/aogriffiths/jupyter-power-container
make build
make serve
```

Notes:
* `make build` - builds the power container image
* `make serve` - runs a Jupyter notebooks webserver using the image
* `make shell` - start a shell, for you to poke arround in, using the image


See Also
========
* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [Datascience notebook](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook)
* [Jupyter notebook tips tricks](https://www.dataquest.io/blog/jupyter-notebook-tips-tricks-shortcuts/)
