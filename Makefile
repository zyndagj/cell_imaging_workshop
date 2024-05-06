JUPYTER=jupyter lab --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token='' --notebook-dir=/mnt/workspace --NotebookApp.allow_origin='*'
JUPYTER_LOCAL=jupyter lab --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token='' --notebook-dir=$(PWD) --NotebookApp.allow_origin='*'

VER=2.2.3
SHELL=/bin/bash -l
TMPDIR=/tmp/$(notdir $(PWD))

ARGS = --rm -it --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 -p 8888:8888 -v $(TMPDIR):/mnt/workspace

container:
	cd docker && docker build -t cellpose:$(VER) .
conda:
	cd docker && docker build -f Dockerfile.conda -t cellpose:$(VER)-conda .


jupyter-conda:
	conda activate cellular \
		&& $(JUPYTER_LOCAL)
jupyter-container:
	cp -r $(PWD) /tmp/
	cd docker && docker run $(ARGS) --gpus all cellpose:$(VER) $(JUPYTER)
computelab:
	cp -r $(PWD) /tmp/
	cd docker && docker run $(ARGS) --gpus \"device=${NV_GPU}\" cellpose:$(VER) $(JUPYTER)
computelab-conda:
	[ -e $(TMPDIR) ] || cp -r $(PWD) /tmp/
	docker run $(ARGS) --gpus \"device=${NV_GPU}\" cellpose:$(VER)-conda bash -lc "conda activate cellular && $(JUPYTER)"
computelab-conda-bash:
	[ -e $(TMPDIR) ] || cp -r $(PWD) /tmp/
	docker run $(ARGS) --gpus \"device=${NV_GPU}\" cellpose:$(VER)-conda bash -l
clean:
	docker run --rm -it -v $(TMPDIR):/mnt/workspace ubuntu bash -c 'rm -rf /mnt/workspace/{.*,*}'
	rm -rf $(TMPDIR)

gdown:
	@$@ -h &> /dev/null || ( echo -e "\n[ERROR] Could not find $@ application. Make sure you're running inside the environment.\n"; exit 1 ) 
curl:
	@$@ -h &> /dev/null || ( echo -e "\n[ERROR] Could not find $@ application. Make sure you're running inside the environment.\n"; exit 1 ) 

data/he-registered-to-dapi-shlee-patch-151_46_7311_5368.xml: gdown
	cd data && gdown 1Ibvmg0L6gdSFpUN1csBszTAm2wbXiqKA
data/he-registered-to-dapi-shlee.tif: curl
	# https://www.10xgenomics.com/analysis-guides/he-to-xenium-dapi-image-registration-with-fiji
	curl -o $@ -sL https://cf.10xgenomics.com/supp/xenium/analysis-guide-images/he-registered-to-dapi-shlee.tif
data/morphology_mip.ome.3.invert.tif: curl
	# https://www.10xgenomics.com/analysis-guides/he-to-xenium-dapi-image-registration-with-fiji
	curl -o $@ -sL https://cf.10xgenomics.com/supp/xenium/analysis-guide-images/morphology_mip.ome.3.invert.tif

data-files: | data/he-registered-to-dapi-shlee-patch-151_46_7311_5368.xml data/he-registered-to-dapi-shlee.tif data/morphology_mip.ome.3.invert.tif
