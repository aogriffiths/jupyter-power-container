# See https://github.com/jupyter/docker-stacks/blob/master/base-notebook

FROM debian:stretch

#ENV DEBIAN_FRONTEND noninteractive

# DOCKER CE
# From https://docs.docker.com/engine/installation/linux/docker-ce/debian/

# Dependancies
RUN apt-get update; apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

# Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

# The repository
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

# Finally, install
RUN apt-get update; apt-get install -y docker-ce


# PYTHON
# python3 comes as standard with debian but pip does not
RUN apt-get install -y python3-pip

# a few more packages and development tools
RUN apt-get install -y build-essential libssl-dev libffi-dev python-dev


# JUPYTER
RUN pip3 install jupyter

# SOME MORE DEPENDANCIES
RUN apt-get update && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation


RUN pip3 install bash_kernel && python3 -m bash_kernel.install

#

ARG USR=poweruser
ARG UID=1001
ARG GRP=docker
ARG GID=1001

RUN useradd -m -s /bin/bash -N -u ${UID} ${USR}

#RUN addgroup -gid ${GID} ${GRP} \
# && addgroup ${USR} ${GRP}

ENV SHELL=/bin/bash
ENV HOME=/home/${USR}

USER $USR
EXPOSE 8888
WORKDIR $HOME
