#!/bin/sh
#BSUB -J vep-CADD-GRCh37
#BSUB -o logs/vep-CADD-GRCh37-%J.out

vep=/hps/software/users/ensembl/repositories/nuno/ensembl-vep/vep
cachedir=/nfs/production/flicek/ensembl/variation/data/VEP
fasta=/nfs/production/flicek/ensembl/variation/data/Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz

vcf=input/CAPICE/test.vcf
snvs=input/CADD/GRCh37/whole_genome_SNVs.tsv.gz
indels=input/CADD/GRCh37/InDels.tsv.gz

perl $vep \
     --i $vcf \
     --o output/${LSB_JOBNAME}-${LSB_JOBID}.vcf --vcf \
     --offline \
     --dir_cache $cachedir \
     --cache_version 105 \
     --assembly GRCh37 \
     --fasta $fasta \
     --plugin CADD,$snvs,$indels
