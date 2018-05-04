FROM debian:stretch

# Prevent "dpkg-preconfigure: unable to re-open stdin" errors
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

#========= THE BASICS =========#
# Things needed by the rest of this container image
# ca-certificates - up to date certs for SSL connections
# build-essential - compilers and make required by many packages below
# curl            - command line tool for transferring data
# gnupg2          - provides gpg, used for Julia and Docker-CE installs
# dirmngr         - required by gpg to perform network operations for managing and downloading certificates
RUN apt-get update && apt-get install -y \
		ca-certificates \
    build-essential \
		curl \
    gnupg2 \
    dirmngr \
 && rm -rf /var/lib/apt/lists/*

#========= PYTHON =========#
# python3 comes as standard with debian but pip and the relevant -dev libraries
# do not. Installing them here.
# python3-pip - Pip Installs Packages (for Python)
# libffi-dev  - Foreign Function Interface, allows code written in one language to call code written in another language.
# libssl-dev  - Development libraries for SSL and TLS
# python-dev  - Header files and a static library for Python
RUN apt-get update && apt-get install -y \
    python3-pip \
    libffi-dev \
    libssl-dev \
    python-dev \
 && rm -rf /var/lib/apt/lists/*

# Upgrade pip and setuptools to the latest
RUN pip3 install --no-cache-dir --upgrade pip setuptools

#========= JUPYTER =========#
# https://jupyter.org/
# The Jupyter notebook provides IPython functionality and more in a web
# interface, allowing you to write, run and experiment with code in one place.
# easily add documentation and see results inline with your code and share
# notebooks with others.
RUN pip3 install --no-cache-dir jupyter


#========= JULIA =========#
# https://julialang.org/
# A high-level, high-performance dynamic programming language for numerical
# computing. It provides a sophisticated compiler, distributed parallel
# execution, numerical accuracy, and an extensive mathematical function library.
# Docker steps taken from:
# https://github.com/docker-library/julia/blob/7dc8567964481b8ff4370671ca57b79f1bab7bb4/Dockerfile

ENV JULIA_PATH /usr/local/julia

# Julia (Binary signing key) <buildbot@julialang.org>
# From https://julialang.org/juliareleases.asc
ENV JULIA_GPG 3673DF529D9049477F76B37566E3C7DC03D6E495

# From https://julialang.org/downloads/
ENV JULIA_VERSION 0.6.2

# https://julialang.org/downloads/#julia-command-line-version
# https://julialang-s3.julialang.org/bin/checksums/julia-0.6.2.sha256
RUN set -ex; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "${dpkgArch##*-}" in \
		amd64) tarArch='x86_64'; dirArch='x64'; sha256='dc6ec0b13551ce78083a5849268b20684421d46a7ec46b17ec1fab88a5078580' ;; \
		armhf) tarArch='armv7l'; dirArch='armv7l'; sha256='1c37aa7cba7372d949a91de53f53609b1b0c9cbeca436eb2fe7f5083d9f62c82' ;; \
		arm64) tarArch='aarch64'; dirArch='aarch64'; sha256='19a8945bdb3d35b7bf0432a9e066fb7831d11d1c1acfe56abd8fcabbf1ebddb4' ;; \
		i386) tarArch='i686'; dirArch='x86'; sha256='099e39ad958aff2ef63841a812f5df62f8553aafc6dd33abb0eb0c67142c5e49' ;; \
		*) echo >&2 "error: current architecture ($dpkgArch) does not have a corresponding Julia binary release"; exit 1 ;; \
	esac; \
	\
	curl -fL -o julia.tar.gz     "https://julialang-s3.julialang.org/bin/linux/${dirArch}/${JULIA_VERSION%[.-]*}/julia-${JULIA_VERSION}-linux-${tarArch}.tar.gz"; \
	curl -fL -o julia.tar.gz.asc "https://julialang-s3.julialang.org/bin/linux/${dirArch}/${JULIA_VERSION%[.-]*}/julia-${JULIA_VERSION}-linux-${tarArch}.tar.gz.asc"; \
	\
	echo "${sha256} *julia.tar.gz" | sha256sum -c -; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
  gpg --keyserver pgp.mit.edu --recv-keys "$JULIA_GPG" || \
  gpg --keyserver keyserver.pgp.com --recv-keys "$JULIA_GPG" || \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$JULIA_GPG" ; \
	gpg --batch --verify julia.tar.gz.asc julia.tar.gz; \
	rm -rf "$GNUPGHOME" julia.tar.gz.asc; \
	\
	mkdir "$JULIA_PATH"; \
	tar -xzf julia.tar.gz -C "$JULIA_PATH" --strip-components 1; \
	rm julia.tar.gz

ENV PATH $JULIA_PATH/bin:$PATH


#========= DOCKER CE =========#
# Install docker community edition, so docker commands can be run from a bash
# Jupyter notebook. Installation steps taken from
# https://docs.docker.com/engine/installation/linux/docker-ce/debian/

## Dependancies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    software-properties-common \
 && rm -rf /var/lib/apt/lists/*

## Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

## Docker’s official repository
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

## docker-ce
RUN apt-get update && apt-get install -y \
		docker-ce \
 && rm -rf /var/lib/apt/lists/*


#========= NODE.JS + KERNEL =========#
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get update && apt-get install -y \
		nodejs \
    npm \
 && rm -rf /var/lib/apt/lists/*

RUN npm config set user 0 \
  & npm config set unsafe-perm true
RUN npm install -g ijavascript \
 && npm cache clean --force

#USER $USR
RUN ijsinstall --install=global
#USER root

#========= RUBY + KERNEL =========#
# https://www.ruby-lang.org/en/documentation/installation/
# https://github.com/SciRuby/iruby
RUN apt-get update && apt-get install -y \
		ruby-full \
    libtool \
    libzmq3-dev \
    libczmq-dev \
 && rm -rf /var/lib/apt/lists/*

 RUN gem install cztop iruby
 RUN iruby register --force


#========= NODE.JS MODULES =========#
# None globally


#========= RUBY GEMS =========#
# None globally
# CONSIDER: https://github.com/SciRuby



#========= JULIA PACKAGES =========#
ADD julia_packages.jl ./
# RUN julia julia_packages.jl



#========= PYTHON MODULES =========#
ADD python_modules.txt ./
RUN pip3 install --no-cache-dir -r python_modules.txt

## EXTRA INSTALL STEPS FOR SOME PYTHON MODULES
# libav-tools   - For matplotlib animation
# pandoc        - For PDF export
# texlive-xetex - For PDF export
# python3-tk    - For the matplotlib TkAgg backend
# adding no-install-recommends here, because these are not for a
# normal graphical environment
RUN apt-get update && apt-get install -y --no-install-recommends \
    libav-tools \
    pandoc \
    texlive-xetex \
    python3-tk \
 && rm -rf /var/lib/apt/lists/*


#  nbextensions (Notebook only)
RUN jupyter contrib nbextension install --system

# nbextensions_configurator  (Notebook only)
# GUI for enabling nbextension other than widgetsnbextension
RUN jupyter nbextensions_configurator enable --system

# rise (Notebook only)
# presentations
RUN jupyter nbextension install rise --py --system
RUN jupyter nbextension enable rise --py --system

# ipywidgets (Notebook and Lab)
# Interactive HTML widgets for Jupyter notebooks.
RUN jupyter nbextension enable widgetsnbextension --py --system
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# qgrid (Notebook and Lab)
# Ediable tables
RUN jupyter nbextension enable qgrid --py --system
RUN jupyter labextension install qgrid


## EXTRA FOR BASH KERNEL
RUN python3 -m bash_kernel.install

## EXTRA FOR RUBY KERNEL
# RUN jupyter kernelspec install .ipython/kernels/ruby

## EXTRA FOR RUBY KERNEL
# https://github.com/matplotlib/jupyter-matplotlib
RUN pip3 install --no-cache-dir ipympl
RUN jupyter nbextension enable ipympl --py --system
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# Nice colours for charts
RUN pip3 install --no-cache-dir colorlover

# To speed up fuzzywuzzy
RUN pip3 install --no-cache-dir python-Levenshtein

# Progress bar
RUN pip3 install --no-cache-dir tqdm

#========= USER SETUP =========#
ARG USR=poweruser
ARG UID=1001
ARG GRP=docker
ARG GID=1001

RUN useradd -m -s /bin/bash -N -u ${UID} ${USR}

# Commenting out this approach for now
# RUN addgroup -gid ${GID} ${GRP} \
# && addgroup ${USR} ${GRP}

ENV SHELL=/bin/bash
ENV HOME=/home/${USR}


USER $USR
WORKDIR $HOME
EXPOSE 8888
