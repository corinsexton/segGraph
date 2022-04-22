#!/bin/bash

#cp intersect_loops_states1.bed intersect_loops_states2.bed ../../segGraph/build_network/


# 1. bedtools intersect all significant loops with chromHMM labels

# 2. create label to label contacts using Hi-C data

# FIX WHEN MERGE MAKES LABELS UNAVAILABLE (n = 260)
./get_graph_csv.py


# REMOVE -1 (no chromhmm labels intersecting)
grep -v '\-\-1' nodes.csv > nodes_fix.csv
grep -v '\-\-1' edges.csv > edges_fix.csv

# 3. create node and edge lists
