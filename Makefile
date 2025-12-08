# DSCI 522 Project Makefile

# Default target
all: download process eda model

# Variables
PYTHON = conda run -n 522_group_project_env python

RAW_DATA=data/raw/iris.csv
PROCESSED_DATA=data/processed/iris_clean.csv
FIGURES_DIR=results/figures
METRICS_DIR=results/metrics

# Ensure output directories exist
$(shell mkdir -p data/raw data/processed $(FIGURES_DIR) $(METRICS_DIR))

# 1. Download raw data
download:
	@echo "Running download script..."
	$(PYTHON) src/download.py --output $(RAW_DATA)

# 2. Process / clean & validate data
process:
	@echo "Running data validation and cleaning script..."
	$(PYTHON) src/process.py --input $(RAW_DATA) --output $(PROCESSED_DATA)

# 3. Run EDA
eda:
	@echo "Running EDA script..."
	$(PYTHON) src/eda.py --input $(PROCESSED_DATA) --output-dir $(FIGURES_DIR)

# 4. Train model and save metrics
model:
	@echo "Running modeling script..."
	$(PYTHON) src/model.py --input $(PROCESSED_DATA) --output-dir $(METRICS_DIR)

# 5. Clean intermediate and output files, but keep folders
clean:
	@echo "Cleaning up all outputs (keeping folders)..."
	rm -rf data/raw/* data/processed/*
	rm -rf results/figures/* results/metrics/*

.PHONY: all download process eda model clean
