FROM quay.io/uninett/jupyter-spark:20210209-02eeb83

MAINTAINER Ove Haugvaldstad <ovewh@student.geo.uio.no>

# Install packages
USER root
RUN apt-get update && apt-get install -y vim

# Install requirements for Python 3

ADD DUST_environment.yml DUST_environment.yml
RUN conda env create -f DUST_environment.yml && conda clean -yt
RUN ["/bin/bash" , "-c", ". /opt/conda/etc/profile.d/conda.sh && \
    conda activate dust && \
    python -m pip install ipykernel && \
    ipython kernel install --name dust && \
    python -m ipykernel install --name=dust && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib
    jupyter labextension install jupyterlab-datawidgets && \
    jupyter labextension install @jupyterlab/debugger && \
    jupyter labextension install @jupyterlab/toc && \
    conda deactivate && \
    conda init bash"]



USER notebook
