#!/bin/bash
set -o pipefail
GENOME_INDEX="ref/tair10_hisat2_index"
THREADS=4
mkdir -p hisat2_bam

declare -A SAMPLE_MAP=(
  [SRR5826942]=0h_1
  [SRR5826943]=0h_2
  [SRR5826944]=0h_3
  [SRR5826945]=1h_1
  [SRR5826946]=1h_2
  [SRR5826947]=1h_3
  [SRR5826948]=3h_1
  [SRR5826949]=3h_2
  [SRR5826950]=3h_3
  [SRR5826951]=6h_1
  [SRR5826952]=6h_2
  [SRR5826953]=6h_3
  [SRR5826954]=12h_1
  [SRR5826955]=12h_2
  [SRR5826956]=12h_3
  [SRR5826957]=24h_1
  [SRR5826958]=24h_2
)

for SRR in "${!SAMPLE_MAP[@]}"; do
  SAMPLE=${SAMPLE_MAP[$SRR]}
  CLEAN_FASTQ="trimmed_fastq/${SRR}_trimmed.fastq.gz"
  BAM_OUTPUT="hisat2_bam/${SAMPLE}.bam"

  if [ -f "$BAM_OUTPUT" ]; then
    echo "[SKIP] $BAM_OUTPUT already exists, skipping."
    continue
  fi

  echo "[INFO] Processing $SAMPLE from $CLEAN_FASTQ..."

  hisat2 -p $THREADS -x $GENOME_INDEX -U $CLEAN_FASTQ \
    | samtools view -@ $THREADS -bS - \
    | samtools sort -@ $THREADS -o "$BAM_OUTPUT" -

  # Check if HISAT2 exited successfully
  if [ $? -ne 0 ]; then
    echo "[ERROR] HISAT2 failed for $SAMPLE, skipping..."
    rm -f "$BAM_OUTPUT"  # remove incomplete BAM
    continue
  fi

  samtools index "$BAM_OUTPUT"

  echo "[DONE] Output: $BAM_OUTPUT"
done

