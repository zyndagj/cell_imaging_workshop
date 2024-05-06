# Cell Imaging Workshop

## 1. Creating and entering Jupyter environment

The environment can either be conda or container based:

### Conda Environment

```
# Creat the "cellpose" environment
conda env create --file docker/cellular.yml --solver=libmamba

# Launcher Jupyter from conda environment
make jupyter-conda

# Register kernel to use in another jupyter environment
conda activate cellular
python -m ipykernel install --user --name=cellular
```

### Container Environment

```
# Create container
make container

# Launch jupyter environment through container
make jupyter-container
```

## 2. Download data

In jupyter, start a terminal and run the following command to download the external data files:

```
make data-files
```

## 3. Run notebooks
