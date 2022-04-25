#!/usr/bin/env python

counter = 1
node_dict = dict()

outfile = open("chr22_edgelist.txt",'w')
infile = open("../../2_build_network/chr22_edges.csv",'r')

ref_file = open("node_labels.tsv",'w')

ref_file.write("id\tnum\n")

infile.readline()

for line in infile:
	ll = line.strip().split(',')
	
	if ll[0] not in node_dict:
		node_dict[ll[0]] = str(counter)
		counter +=1
		ref_file.write(ll[0] + '\t' + node_dict[ll[0]] + '\n')

	if ll[1] not in node_dict:
		node_dict[ll[1]] = str(counter)
		counter +=1
		ref_file.write(ll[1] + '\t' + node_dict[ll[1]] + '\n')
	
	
	outfile.write(node_dict[ll[0]] + ' ' + node_dict[ll[1]] + '\n')

outfile.close()
infile.close()
