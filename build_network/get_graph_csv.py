#!/usr/bin/env python


class_dict = dict()
counter = -1
labs = []

for l in open("chromhmm_classes.txt"):
	class_dict[l.strip()] = counter
	labs.append(l.strip())
	counter +=1

# nodes = bed region
# edges = loop calls

infile1 = open("/Users/coripenrod/Documents/UNLV/Year4/nmf3D/get_contact_labels/intersect_loops_states1.bed",'r')
infile2 = open("/Users/coripenrod/Documents/UNLV/Year4/nmf3D/get_contact_labels/intersect_loops_states2.bed",'r')

edge_file = open('edges.csv', 'w')
node_file = open('nodes.csv', 'w')

edge_file.write("from,to,score\n")
node_file.write("id," + ','.join(labs) + "\n")

node_dict = dict()

for f in [infile1,infile2]:
	for line in f:
		ll = line.strip().split()
	
		reg1 = ll[0] + ':' + ll[1] + '-' + ll[2]
		reg2 = ll[3] + ':' + ll[4] + '-' + ll[5]
		score = ll[6]
		chromHMM_lab = ll[10]

		node_dict[reg1] =  ['0'] * 18
		node_dict[reg1][class_dict[chromHMM_lab]] = '1'

		edge_file.write(reg1 + ',' + reg2 + ',' + score + '\n')

for i in node_dict:
	node_file.write(i + ',' + ','.join(node_dict[i]) + '\n')

node_file.close()
edge_file.close()


