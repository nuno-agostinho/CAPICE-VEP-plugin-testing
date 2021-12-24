#!/bin/sh
#BSUB -J vep-CAPICE
#BSUB -o logs/vep-CAPICE-%J.out

vep=/hps/software/users/ensembl/repositories/nuno/ensembl-vep/vep
cachedir=/nfs/production/flicek/ensembl/variation/data/VEP

fasta=/nfs/production/flicek/ensembl/variation/data/Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz
snvs=input/CAPICE/GRCh37/capice_v1.0_build37_snvs.tsv.gz
indels=input/CAPICE/GRCh37/capice_v1.0_build37_indels.tsv.gz
vcf=input/CAPICE/test.vcf

perl $vep \
     --i $vcf \
     --o output/${LSB_JOBNAME}-${LSB_JOBID}.txt \
     --offline \
     --dir_cache $cachedir \
     --cache_version 105 \
     --assembly GRCh37 \
     --fasta $fasta \
     --force_overwrite \
     --plugin CAPICE,$snvs,$indels
