#!/bin/sh
#BSUB -J vep-CAPICE
#BSUB -o logs/vep-CAPICE-%J.out

vep=/hps/software/users/ensembl/repositories/nuno/ensembl-vep/vep
cachedir=/nfs/production/flicek/ensembl/variation/data/VEP

fasta=/nfs/production/flicek/ensembl/variation/data/Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz
snvs=input/CAPICE/GRCh37/capice_v1.0_build37_snvs.tsv.gz
indels=input/CAPICE/GRCh37/capice_v1.0_build37_indels.tsv.gz

capice_plugin () {
    echo " -> Running CAPICE (perl$perlVersion, $type, $format) with VCF $vcf"
    plenv local $perlVersion
    perl $vep --i $vcf \
              --o output/${LSB_JOBNAME}-${LSB_JOBID}.$perl.$type.$format \
              --$format \
              --assembly GRCh37 \
              --fasta $fasta \
              --force_overwrite \
              $@ \
              --plugin CAPICE,$snvs,$indels
}

capice_cache () {
    type=cache
    capice_plugin --offline \
                  --dir_cache $cachedir \
                  --cache_version 105
}

capice_database () {
    type=database
    capice_plugin --database
}

vcf=input/CAPICE/test.vcf
for vepCapice in capice_cache capice_database; do
    for perlVersion in 5.14.4 5.24.1 5.30.0; do
        for format in json tab vcf; do
            $vepCapice
        done
    done
done

vcf=input/NA12878.vcf.gz
perlVersion=5.14.4
format=tab
capice_cache
