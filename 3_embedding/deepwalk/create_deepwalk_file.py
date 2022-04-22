#!/usr/bin/env python

counter = 1
node_dict = dict()

outfile = open("chr22_edgelist.txt",'w')
infile = open("../../2_build_network/chr22_edges.csv",'r')

infile.readline()

for line in infile:
	ll = line.strip().split(',')
	
	if ll[0] not in node_dict:
		node_dict[ll[0]] = str(counter)
		counter +=1

	if ll[1] not in node_dict:
		node_dict[ll[1]] = str(counter)
		counter +=1
	
	
	outfile.write(node_dict[ll[0]] + ' ' + node_dict[ll[1]] + '\n')

outfile.close()
infile.close()
