

#https://kateto.net/network-visualization

#setwd("segGraph/visualizations/")
library(igraph)
library(tidyverse)


nodes <- read.csv("../2_build_network/chr22_nodes.csv", header=T, as.is=T)
links <- read.csv("../2_build_network/chr22_edges.csv", header=T, as.is=T)

#nodes_all <- unique(nodes_all)
#links_all <- unique(links_all)
#
## nodes_all <- nodes %>% group_by(id) %>% summarise(chrom_list = paste0(chromhmm, collapse = ","))
#
#nodes <- nodes_all[grepl('chr22_h1',nodes_all$id),]
#links <- links_all[grepl('chr22_h1',links_all$from),]

net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 

# Generate colors based on media type:
colrs <- c("gray50", "tomato", "gold")
V(net)$color <- colrs[V(net)$label]


png("network.png", height = 9000, width = 9000, res = 150)
plot(simplify(net), vertex.size = 0.5,vertex.label=NA,edge.arrow.size=0)
dev.off()

#,edge.width=links$score*250

png("degree.png",height = 1200, width = 2000, res = 200)
hist(degree(simplify(net)))
dev.off()


library('visNetwork') 
visNetwork(nodes, links, width="100%", height="400px")

# We'll start by adding new node and edge attributes to our dataframes. 
vis.nodes <- nodes
vis.links <- links

vis.nodes$shape  <- "dot"  
vis.nodes$shadow <- F # Nodes will drop shadow
vis.nodes$title  <- vis.nodes$EnhA1 # Text on click
vis.nodes$label  <- vis.nodes$type.label # Node label
vis.nodes$size   <- vis.nodes$audience.size # Node size
vis.nodes$borderWidth <- 2 # Node border width

vis.nodes$color.background <- c("tomato", "gold")[vis.nodes$Het +1] 
vis.nodes$color.border <- "black"
vis.nodes$color.highlight.background <- "orange"
vis.nodes$color.highlight.border <- "darkred"

visNetwork(vis.nodes, vis.links)

vis.links$width <- 1+links$score*500 # line width
vis.links$color <- "gray"    # line color  
vis.links$arrows <- "middle" # arrows: 'from', 'to', or 'middle'
vis.links$smooth <- FALSE    # should the edges be curved?
vis.links$shadow <- FALSE    # edge shadow

visnet <- visNetwork(vis.nodes, vis.links)
visnet

visOptions(visnet, highlightNearest = TRUE, selectedBy = "type.label")

