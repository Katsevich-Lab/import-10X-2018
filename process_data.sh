#!/bin/bash

MAIN_DIR=$(source ~/.research_config; echo $LOCAL_10X_2018_DATA_DIR)

# Verify that MAIN_DIR is set
if [ -z "$MAIN_DIR" ]; then
  echo "Error: MAIN_DIR is not set. Check .research_config file."
  exit 1
fi

RAW_DIR="${MAIN_DIR}raw/"
REFDATA_DIR="${RAW_DIR}refdata-gex-GRCh38-2020-A/"

# Step 2: Process data
PROCESSED_DIR="${MAIN_DIR}processed/"
mkdir -p "$PROCESSED_DIR"
cd "$PROCESSED_DIR"

# Check if Cell Ranger is installed
if ! command -v cellranger &> /dev/null; then
  echo "Error: cellranger command not found."
  exit 1
fi

# Step 2.1: Run Cell Ranger count for each SRR
for ID in pbmc_1k_v3 pbmc_10k_v3; do
  cellranger count --id="${ID}" \
                   --transcriptome="$REFDATA_DIR" \
                   --fastqs="${RAW_DIR}/${ID}_fastqs" \
                   --sample="${ID}" \
                   --create-bam=true 
done

echo "Processing complete!"