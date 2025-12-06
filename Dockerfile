FROM quay.io/jupyter/minimal-notebook:latest

COPY conda-lock.yml /tmp/conda-lock.yml

RUN mamba create --file /tmp/conda-lock.yml \
	&& mamba clean --all -y -f \
	&& fix-permissions "${CONDA_DIR}" \
	&& fix-permissions "/home/${NB_USER}"