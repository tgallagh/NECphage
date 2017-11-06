#!/bin/bash
#$ -N NECassembly
#$ -q free64,pub64,bio
#$ -m e
#$ -pe make 8
#$ -R y
#$ -t 1-4

# 11/06/17
# NEC phage assembly with A5 and quality report of filtered reads  

STARTDIR=/bio/tgallagh/NECphage/data/processed/filteredreads/
PREFIX=/bio/tgallagh/NECphage/data/raw/prefix.txt

module load brew/a5

input=$(head -n $SGE_TASK_ID $PREFIX | tail -n 1)

ASSEMBLY=/bio/tgallagh/NECphage/data/processed/assembly/
cd $ASSEMBLY

#have to use relative path for A5 output 

a5_pipeline.pl $STARTDIR$input\paired.derep.read1.fastq.fastq $STARTDIR$input\paired.derep.read2.fastq.fastq $input





