#!/bin/bash

# Step 1: Download data
# Extract the path to LOCAL_10X_2018_DATA_DIR from .research_config
MAIN_DIR=$(source ~/.research_config; echo $LOCAL_10X_2018_DATA_DIR)

# Check if MAIN_DIR is set
if [ -z "$MAIN_DIR" ]; then
  echo "Error: MAIN_DIR is not set. Check .research_config file."
  exit 1
fi

RAW_DIR="${MAIN_DIR}raw/"
mkdir -p "$RAW_DIR"

# Step 1.1: Download FastQ files
cd "$RAW_DIR" || exit
wget https://cf.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_1k_v3/pbmc_1k_v3_fastqs.tar
tar -xvf pbmc_1k_v3_fastqs.tar
wget https://s3-us-west-2.amazonaws.com/10x.files/samples/cell-exp/3.0.0/pbmc_10k_v3/pbmc_10k_v3_fastqs.tar
tar -xvf pbmc_10k_v3_fastqs.tar


# Step 1.2: Download and extract the GRCh38 transcriptome database
cd "$RAW_DIR" || exit
if [ ! -f "refdata-gex-GRCh38-2020-A.tar.gz" ]; then
  wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz
fi
if [ ! -d "refdata-gex-GRCh38-2020-A" ]; then
  tar -zxvf refdata-gex-GRCh38-2020-A.tar.gz
fi
REFDATA_DIR="${RAW_DIR}refdata-gex-GRCh38-2020-A/"

echo "Downloading complete!"