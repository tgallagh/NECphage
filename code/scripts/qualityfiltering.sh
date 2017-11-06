#!/bin/bash
#$ -N filterreportNEC
#$ -q free64,pub64,bio
#$ -m e
#$ -pe make 8
#$ -R y
#$ -t 1-4


# quality filter NEC phage raw reads
cd /bio/tgallagh/NECphage/data/raw
PREFIX=/bio/tgallagh/NECphage/data/raw/prefix.txt
DEST=/bio/tgallagh/NECphage/data/processed/filteredreadsi

module load trimmomatic/0.35
module load prinseq-lite/0.20.4

input=$(head -n $SGE_TASK_ID $PREFIX | tail -n 1)
TRIMMED=/bio/tgallagh/NECphage/data/processed/filteredreads/
java -jar /data/apps/trimmomatic/0.35/trimmomatic-0.35.jar PE -phred33 $input\read1.fastq $input\read2.fastq $TRIMMED$input\paired.read1.fastq $TRIMMED$input\unpaired.read1.fastq $TRIMMED$input\paired.read2.fastq $TRIMMED$input\unpaired.read2.fastq  ILLUMINACLIP:/bio/tgallagh/alladaptors.fa:2:30:10 LEADING:25 TRAILING:25 SLIDINGWINDOW:4:20 MINLEN:50



#Derep the paired files  

prinseq-lite.pl -fastq $TRIMMED$input\paired.read1.fastq  -derep 1 -derep_min 2  -out_good $TRIMMED$input\paired.derep.read1.fastq -out_bad null -out_format 3 


prinseq-lite.pl -fastq $TRIMMED$input\paired.read2.fastq  -derep 1 -derep_min 2  -out_good $TRIMMED$input\paired.derep.read2.fastq -out_bad null -out_format 3 


# Prinseq reports of output 
REPORT=/bio/tgallagh/NECphage/output/reports/filteredprinseq/

prinseq-lite.pl -fastq $TRIMMED$input\paired.read1.fastq  -graph_data $REPORT$input\paired.read1.gd -graph_stats ld,gc,qd,ns,pt,ts,aq,de,da,sc,dn


prinseq-lite.pl -fastq $TRIMMED$input\paired.read2.fastq  -graph_data $REPORT$input\paired.read2.gd -graph_stats ld,gc,qd,ns,pt,ts,aq,de,da,sc,dn



