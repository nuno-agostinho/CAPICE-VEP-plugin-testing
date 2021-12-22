#!/bin/sh
#BSUB -J vep-CADDmod
#BSUB -o logs/vep-CADDmod-%J.out

# Custom plugins
export PERL5LIB=/homes/nuno/workspace/ENSVAR-4463-CAPICE/plugins:$PERL5LIB

vep=/hps/software/users/ensembl/repositories/nuno/ensembl-vep/vep
cachedir=/nfs/production/flicek/ensembl/variation/data/VEP
fasta=/nfs/production/flicek/ensembl/variation/data/Homo_sapiens.GRCh38.dna.toplevel.fa.gz

vcf=input/test.vcf
snvs=input/CADD/GRCh38/whole_genome_SNVs.tsv.gz
indels=input/CADD/GRCh38/gnomad.genomes.r3.0.indel.tsv.gz

perl $vep \
     --i $vcf \
     --o output/${LSB_JOBNAME}-${LSB_JOBID}.txt \
     --offline \
     --dir_cache $cachedir \
     --cache_version 105 \
     --assembly GRCh38 \
     --fasta $fasta \
     --plugin CADDmod,$snvs,$indels
