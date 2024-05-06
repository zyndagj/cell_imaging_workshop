FROM nvcr.io/nvidia/pytorch:24.03-py3

RUN pip uninstall -y opencv opencv-python-headless \
	&& rm -rf /usr/local/lib/python3.10/dist-packages/cv2

# Save all existing packages and versions to a text file
RUN pip list | awk '{print$1"=="$2}' | tail +3 > /root/base_constraints.txt

RUN pip install -c /root/base_constraints.txt \
	opencv-python-headless \
	cellpose==3.0.7 \
	geopandas \
	jupyterlab_nvdashboard
	gdown
