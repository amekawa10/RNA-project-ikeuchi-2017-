#!/bin/bash

# Download RNA-seq fastq.gz files from ENA using official links
# Save to fastq/, check each download, and show sorted list at the end

mkdir -p fastq

download_check() {
    url=$1
    fname=$(basename "$url")
    out="fastq/$fname"

    wget -nc -P fastq/ "$url"

    if [ ! -s "$out" ]; then
        echo "[ERROR] Download failed or file empty: $fname"
        rm -f "$out"
    fi
}

# Download using ENA-provided mapping
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/008/SRR5826958/SRR5826958.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/002/SRR5826942/SRR5826942.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/000/SRR5826950/SRR5826950.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/003/SRR5826953/SRR5826953.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/007/SRR5826947/SRR5826947.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/009/SRR5826949/SRR5826949.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/004/SRR5826944/SRR5826944.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/007/SRR5826957/SRR5826957.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/005/SRR5826955/SRR5826955.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/006/SRR5826946/SRR5826946.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/004/SRR5826954/SRR5826954.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/001/SRR5826951/SRR5826951.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/002/SRR5826952/SRR5826952.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/008/SRR5826948/SRR5826948.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/006/SRR5826956/SRR5826956.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/005/SRR5826945/SRR5826945.fastq.gz
download_check ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR582/003/SRR5826943/SRR5826943.fastq.gz

# Show sorted file list
echo
echo "[INFO] Downloaded files (sorted):"
ls fastq/SRR*.fastq.gz 2>/dev/null | sort -V

