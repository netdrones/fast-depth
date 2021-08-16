.ONESHELL:
SHELL=/bin/bash
ENV_NAME=depth
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

install: download-models
	sudo apt-get update
	sudo apt-get install -y libhdf5-serial-dev hdf5-tools
	conda env update -f environment.yml

nyu-depth:
	mkdir data && cd data
	wget http://datasets.lids.mit.edu/fastdepth/data/nyudepthv2.tar.gz
	tar -xvf nyudepthv2.tar.gz && rm -f nyudepthv2.tar.gz

download-models:
	if [ ! -d models ]
	then
		mkdir models && cd models
		wget http://datasets.lids.mit.edu/fastdepth/results/mobilenet-nnconv5.pth.tar
		wget http://datasets.lids.mit.edu/fastdepth/results/mobilenet-nnconv5dw-skipadd-pruned.pth.tar
		wget http://datasets.lids.mit.edu/fastdepth/results/mobilenet-nnconv5dw-skipadd.pth.tar
		wget http://datasets.lids.mit.edu/fastdepth/results/mobilenet-nnconv5dw.pth.tar
	fi
