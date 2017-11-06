#!/bin/bash
#$ -N NECspades
#$ -q free64,pub64,bio
#$ -m e
#$ -pe make 8
#$ -R y
#$ -t 1-4

# 11/06/17
# NEC phage assembly with A5 and quality report of filtered reads  

STARTDIR=/bio/tgallagh/NECphage/data/processed/filteredreads/
PREFIX=/bio/tgallagh/NECphage/data/raw/prefix.txt


input=$(head -n $SGE_TASK_ID $PREFIX | tail -n 1)

ASSEMBLY=/bio/tgallagh/NECphage/data/processed/spadesassembly/


module load SPAdes/3.8.2
cd $STARTDIR

spades.py --pe1-1  --pe2-2 -o $ASSEMBLY 







