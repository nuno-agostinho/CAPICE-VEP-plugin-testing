#!/bin/sh
#BSUB -J vep
#BSUB -o logs/vep-%J.out

vep=/hps/software/users/ensembl/repositories/nuno/ensembl-vep/vep
cachedir=/nfs/production/flicek/ensembl/variation/data/VEP
fasta=/nfs/production/flicek/ensembl/variation/data/Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz
vcf=/hps/nobackup/flicek/ensembl/variation/dlemos/vep/input_files/disgenet_input.vcf

perl $vep \
     --i $vcf \
     --o output/${LSB_JOBNAME}-${LSB_JOBID}.txt \
     --offline \
     --dir_cache $cachedir \
     --cache_version 105 \
     --assembly GRCh37 \
     --fasta $fasta
