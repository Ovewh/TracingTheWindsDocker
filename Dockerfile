FROM quay.io/uninett/jupyter-spark:20210209-02eeb83

MAINTAINER Ove Haugvaldstad <ovewh@student.geo.uio.no>

# Install packages
USER root
RUN apt-get update && apt-get install -y vim

# Install requirements for Python 3

ADD Dust_environment.yml Dust_environment.yml

RUN conda env update -f Dust_environment.yml


USER notebook
