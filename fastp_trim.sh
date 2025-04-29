#!/bin/bash

# This script runs fastp QC and trimming on all fastq.gz files in the "fastq/" directory.
# It trims adapters, filters low-quality reads, and removes reads shorter than 20 bp.
# Both JSON and HTML reports are generated for each sample.

# Check if fastp is installed
if ! command -v fastp &> /dev/null; then
    echo "[ERROR] fastp is not installed. Please install it first."
    exit 1
fi

# Create output directories
mkdir -p trimmed_fastq
mkdir -p fastp_reports/json
mkdir -p fastp_reports/html

# Loop through each fastq.gz file
for file in fastq/*.fastq.gz; do
    if [ ! -s "$file" ]; then
        echo "[ERROR] File missing or empty: $file"
        continue
    fi

    # Extract sample name
    sample=$(basename "$file" .fastq.gz)

    # Run fastp with trimming and filtering options
    fastp \
        --in1 "$file" \
        --out1 "trimmed_fastq/${sample}_trimmed.fastq.gz" \
        --html "fastp_reports/html/${sample}_fastp.html" \
        --json "fastp_reports/json/${sample}_fastp.json" \
        --thread 4 \
        --length_required 20 \
        --cut_front \
        --cut_tail \
        --cut_window_size 4 \
        --cut_mean_quality 20 \
        --detect_adapter_for_pe \
        --report_title "${sample} fastp QC and Trimming"

    echo "[INFO] Finished QC and trimming for $sample"
done

echo "[DONE] All QC reports saved under 'fastp_reports/', trimmed fastq.gz files saved under 'trimmed_fastq/'"

