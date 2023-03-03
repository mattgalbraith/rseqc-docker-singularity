[![Docker Image CI](https://github.com/mattgalbraith/rseqc-docker-singularity/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mattgalbraith/rseqc-docker-singularity/actions/workflows/docker-image.yml)

# rseqc-docker-singularity

## Build Docker container for RseQC and (optionally) convert to Apptainer/Singularity.  

The RSeQC package provides a number of useful modules that can comprehensively evaluate high throughput sequence data especially RNA-seq data.  
https://rseqc.sourceforge.net/  
  
#### Requirements:
Install within image using micromamba  
https://github.com/mamba-org/micromamba-docker  
  
## Build docker container:  

### 1. For RSeQC installation instructions:  
https://rseqc.sourceforge.net/#installation  
https://bioconda.github.io/recipes/rseqc/README.html  


### 2. Build the Docker Image

#### To build image from the command line:  
``` bash
# Assumes current working directory is the top-level rseqc-docker-singularity directory
docker build -t rseqc:5.0.1 . # tag should match software version
```
* Can do this on [Google shell](https://shell.cloud.google.com)

#### To test this tool from the command line:
``` bash
docker run --rm -it rseqc:5.0.1 bam_stat.py --help # or any other RseQC script
```

## Optional: Conversion of Docker image to Singularity  

### 3. Build a Docker image to run Singularity  
(skip if this image is already on your system)  
https://github.com/mattgalbraith/singularity-docker

### 4. Save Docker image as tar and convert to sif (using singularity run from Docker container)  
``` bash
docker images
docker save <Image_ID> -o rseqc5.0.1-docker.tar && gzip rseqc5.0.1-docker.tar # = IMAGE_ID of rseqc image
docker run -v "$PWD":/data --rm -it singularity:1.1.5 bash -c "singularity build /data/rseqc5.0.1.sif docker-archive:///data/rseqc5.0.1-docker.tar.gz"
```
NB: On Apple M1/M2 machines ensure Singularity image is built with x86_64 architecture or sif may get built with arm64  

Next, transfer the rseqc5.0.1.sif file to the system on which you want to run RseQC from the Singularity container  

### 5. Test singularity container on (HPC) system with Singularity/Apptainer available  
``` bash
# set up path to the Singularity container
RSEQC_SIF=path/to/rseqc5.0.1.sif

# Test that RseQC scripts can run from Singularity container
singularity run $RSEQC_SIF bam_stat.py --help # depending on system/version, singularity may be called apptainer
```