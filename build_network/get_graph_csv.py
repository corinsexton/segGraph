#!/usr/bin/env python

from collections import defaultdict


class_dict = dict()
counter = -1
labs = []

for l in open("chromhmm_classes.txt"):
	class_dict[l.strip()] = counter
	labs.append(l.strip())
	counter +=1

# nodes = bed region
# edges = loop calls

infile2 = open("/Users/coripenrod/Documents/UNLV/Year4/nmf3D/get_contact_labels/intersect_loops_states2.bed",'r')

#chr1_endo	156445000	156450000	chr1_endo	156385000	156390000	0.0760049986826584	chr1_endo	156445208	156446608	ReprPCWk	1400
#chr1_endo	156445000	156450000	chr1_endo	156385000	156390000	0.0760049986826584	chr1_endo	156446608	156456008	Quies	3392
#chr1_endo	156130000	156135000	chr1_endo	156090000	156095000	0.07461048396265937	chr1_endo	156128209	156131009	EnhA1	1009
#chr1_endo	156130000	156135000	chr1_endo	156090000	156095000	0.07461048396265937	chr1_endo	156131009	156133609	TxWk	2600

edge_file = open('edges.csv', 'w')
node_file = open('nodes.csv', 'w')

edge_file.write("from,to,score\n")
node_file.write("id,label\n")

first_loops_dict = defaultdict(list)

infile1 = open("/Users/coripenrod/Documents/UNLV/Year4/segGraph/build_network/intersect_loops_states1.bed",'r')
for line in infile1:
	ll =line.strip().split()

	reg1 = ll[0] + ':' + ll[1] + '-' + ll[2]
	reg2 = ll[3] + ':' + ll[4] + '-' + ll[5]
	score = ll[6]
	reg3 = ll[7] + ':' + ll[8] + '-' + ll[9]
	label = ll[10]

	first_loops_dict[reg2].append(reg3)
	node_file.write(reg3 + ',' + label + '\n')


infile2 = open("/Users/coripenrod/Documents/UNLV/Year4/segGraph/build_network/intersect_loops_states2.bed",'r')
for line in infile2:
	ll =line.strip().split()

	reg1 = ll[0] + ':' + ll[1] + '-' + ll[2]
	reg2 = ll[3] + ':' + ll[4] + '-' + ll[5]
	score = ll[6]
	reg3 = ll[7] + ':' + ll[8] + '-' + ll[9]
	label = ll[10]

	node_file.write(reg3 + ',' + label + '\n')

	for loop in first_loops_dict[reg1]:
		edge_file.write(reg3 + ',' + loop + ',' + score + '\n')
		edge_file.write(loop + ',' + reg3 + ',' + score + '\n')






node_file.close()
edge_file.close()


