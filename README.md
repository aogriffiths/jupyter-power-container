Power Jupyter Container
=======================

An veritable kitchen sink of things you can do with Jupyter notebooks. Like:

* The obvious three kernels, which **JUPYT**e**R** gets it's name from, **JU**lia, **PYT**hon and **R**. Plus a few more
handy ones - Javascript, Bash and Ruby.
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
* make

Steps:
```bash
docker pull power-jupyter-container
make serve
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
git clone https://github.com/aogriffiths/power-jupyter-container
make
make serve
```


Commands
========

* `make build` - builds the power container image
* `make serve` - runs a Jupyter notebooks webserver using the image
* `make shell` - start a shell, for you to poke arround in, using the image

See Also
========
* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [Datascience notebook](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook)
* [Jupyter notebook tips tricks](https://www.dataquest.io/blog/jupyter-notebook-tips-tricks-shortcuts/)


Speed Up Builds (WORK IN PROGRESS)
================

Docker caches the steps from your build file in the order they successfully
complete, the trouble is if you change an early step in your Dockerfile the
cache is invalidated  for all subsequent steps, and all the packages downloads
they do will happen again.

It is possible to cache apt-get packages, node.js npn modules, python pip
packages, ruby gems, Julia packages (etc, etc) using the well known Squid proxy,
so, when your docker build attempts to re-download them it will get a copy from
the squid cache. This speeds the build up and saves bandwidth.

There are a couple of ways do do it:

1. Add commands to the top of your Dockerfile, to see if squid is running
somewhere sensible (i.e. on a standard ip address and port) and then tell apt,
pip, gem, npm and any other package managers to use it. An example of using this
technique for apt-get is [here](https://gist.github.com/dergachev/8441335).
  - Pro: The build process detects and uses the proxy if it's there and works
  normally if it's not there.
  - Pro: Other containers won't use the proxy
  - Con: After the first run
