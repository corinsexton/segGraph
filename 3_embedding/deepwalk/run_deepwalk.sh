#!/bin/bash

#module load conda
#conda activate deepwalk

#https://github.com/phanein/deepwalk/issues/125

# took 1 minute


deepwalk --format edgelist --input chr22_edgelist.txt \
		--output chr22.embeddings
