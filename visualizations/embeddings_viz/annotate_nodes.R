
setwd("/Users/coripenrod/Documents/UNLV/Year4/segGraph/visualizations/embeddings_viz")

library(tidyverse)

labs <- read_tsv("../../3_embedding/deepwalk/node_labels.tsv")
ann <- read_csv("../../2_build_network/chr22_nodes.csv")

all <- merge(ann,labs, by = 'id')
