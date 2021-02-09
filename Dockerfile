FROM quay.io/uninett/jupyter-spark:20210209-02eeb83

MAINTAINER Ove Haugvaldstad <ovewh@student.geo.uio.no>

# Install packages
USER root
RUN apt-get update && apt-get install -y vim

# Install requirements for Python 3

ADD DUST_environment.yml DUST_environment.yml

RUN conda env create -f DUST_environment.yml


USER notebook
