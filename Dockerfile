################# BASE IMAGE ######################
FROM --platform=linux/amd64 mambaorg/micromamba:1.3.1-focal
# Micromamba for fast building of small conda-based containers.
# https://github.com/mamba-org/micromamba-docker
# The 'base' conda environment is automatically activated when the image is running.

################## METADATA ######################
LABEL base_image="mambaorg/micromamba:1.3.1-focal"
LABEL version="1.0.0"
LABEL software="RSeQC"
LABEL software.version="5.0.1"
LABEL about.summary="The RSeQC package provides a number of useful modules that can comprehensively evaluate high throughput sequence data especially RNA-seq data."
LABEL about.home="https://rseqc.sourceforge.net/"
LABEL about.documentation="https://rseqc.sourceforge.net/"
LABEL about.license_file="https://rseqc.sourceforge.net/#license"
LABEL about.license="GNU GPLv3"

################## MAINTAINER ######################
MAINTAINER Matthew Galbraith <matthew.galbraith@cuanschutz.edu>

################## INSTALLATION ######################

# Copy the yaml file to your docker image and pass it to micromamba
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes


