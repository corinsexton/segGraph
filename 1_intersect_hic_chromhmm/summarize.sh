#!/bin/bash


## fix znf-rpts mislabel (one-time)

#awk '{ print gensub(/ZNF\/Rpts/, "ZNF-Rpts", "g");}' ../annotations/chromhmm_epimap/H1.bed  > x
#mv x ../annotations/chromhmm_epimap/H1.bed

chromHMM=../annotations/chromhmm_epimap/H1.bed
loops=../annotations/loops/h1.loops.75

cut -f1,2,3,4,5,6,8 $loops > ../annotations/loops/h1.loops.cut

loops=../annotations/loops/h1.loops.cut


cut -f1-4 $chromHMM > chromHMM_coordonly.bed
cut -f4 chromHMM_coordonly.bed | sort | uniq > class_meta.txt

##### LOOPS FILE, 7th COLUMN NEEDS TO BE SCORE

### STEP 1: Intersect loops (micro-c) with chromHMM labels
bedtools intersect -a $loops -b chromHMM_coordonly.bed -F .3 -wao > intersect_loops_states2.bed
awk '{print $4"\t"$5"\t"$6"\t"$1"\t"$2"\t"$3"\t"$7}' $loops | \
	bedtools intersect -a - -b chromHMM_coordonly.bed -wao -F .3 > intersect_loops_states1.bed

