#!/bin/sh
#BSUB -J vep-DisGeNET
#BSUB -o logs/vep-DisGeNET-%J.out

vep=/hps/software/users/ensembl/repositories/nuno/ensembl-vep/vep
cachedir=/nfs/production/flicek/ensembl/variation/data/VEP
fasta=/nfs/production/flicek/ensembl/variation/data/Homo_sapiens.GRCh38.dna.toplevel.fa.gz
vcf=/hps/nobackup/flicek/ensembl/variation/dlemos/vep/input_files/disgenet_input.vcf
DisGeNET_file=/nfs/production/flicek/ensembl/variation/data/DisGeNET/Nov_2020/all_variant_disease_pmid_associations_final.tsv.gz

perl $vep \
     --i $vcf \
     --o output/${LSB_JOBNAME}-${LSB_JOBID}.txt \
     --offline \
     --dir_cache $cachedir \
     --cache_version 104 \
     --assembly GRCh38 \
     --fasta $fasta \
     --plugin DisGeNET,file=$DisGeNET_file
