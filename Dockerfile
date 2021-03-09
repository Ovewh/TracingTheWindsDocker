FROM quay.io/uninett/jupyter-spark:20210217-9753737

MAINTAINER Ove Haugvaldstad <ovewh@student.geo.uio.no>

# Install packages
USER root
RUN apt-get update && apt-get install -y vim

RUN conda config --set channel_priority strict && \
    conda install --quiet --yes --update-all -c conda-forge \
    'xeus-python'\
    'nb_conda_kernels'\
    'fortran_kernel'
# Install requirements for Python 3

ADD DUST_environment.yml DUST_environment.yml
RUN conda env create -f DUST_environment.yml && conda clean -yt
RUN ["/bin/bash" , "-c", ". /opt/conda/etc/profile.d/conda.sh && \
    conda activate dust && \
    ipython kernel install --name dust && \
    python -m ipykernel install --name=dust && \
    git clone https://github.com/Ovewh/DUST.git /home/notebook/DUST && \
    pip install -e /home/notebook/DUST && \ 
    jupyter labextension install jupyterlab-datawidgets && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib && \
    jupyter labextension install @jupyterlab/toc && \
    conda deactivate && \
    conda init bash"]



USER notebook
