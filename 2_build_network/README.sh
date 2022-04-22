#!/bin/bash

#cp intersect_loops_states1.bed intersect_loops_states2.bed ../../segGraph/build_network/


# 1. bedtools intersect all significant loops with chromHMM labels

# 2. create label to label contacts using Hi-C data

./get_graph_csv.py

head -n 1 nodes.csv > nodes_fix.csv
head -n 1 edges.csv > edges_fix.csv


# REMOVE -1 (no chromhmm labels intersecting)
grep -v '\-\-1' nodes.csv | sort | uniq >> nodes_fix.csv
grep -v '\-\-1' edges.csv >> edges_fix.csv

mv nodes_fix.csv nodes.csv
mv edges_fix.csv edges.csv

head -n 1 nodes.csv > chr22_nodes.csv
head -n 1 edges.csv > chr22_edges.csv

grep 'chr22' nodes.csv >> chr22_nodes.csv
grep 'chr22' edges.csv >> chr22_edges.csv


# 3. create node and edge lists
