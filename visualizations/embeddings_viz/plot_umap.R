
setwd("/Users/coripenrod/Documents/UNLV/Year4/segGraph/visualizations/embeddings_viz")

library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization


mat <- read_delim("../../3_embeddings/deepwalk/chr22.embeddings",' ',skip = 1,col_names = F)

m <- mat[,-1]

z <- kmeans(m,centers = 5)

table(z$cluster)

png("pca.png",height = 800, width= 800,res = 200)
fviz_cluster(z, geom = "point", data = m,pointsize = 0.5)
dev.off()


library(umap)
library(plotly) 

# 2-D plot

run_umap_fig <- function(data,data.labels,neighbors,mindist) {
  data.umap = umap(data, n_components = 2, n_neighbors = neighbors, min_dist = mindist, random_state = 15) 
  
  layout <- data.umap[["layout"]] 
  layout <- data.frame(layout) 
  final <- cbind(layout, data.labels) 
  
  fig <- plot_ly(final, x = ~X1, y = ~X2, color = ~as.character(data.labels), colors = c('#636EFA','#EF553B','#00CC96'), type = 'scatter', mode = 'markers')%>%  
    layout(
      plot_bgcolor = "#e5ecf6",
      legend=list(title=list(text='cluster')), 
      xaxis = list( 
        title = "0"),  
      yaxis = list( 
        title = "1")) 
  
  fig

}

data <- m
data.labels <- z$cluster


fig1 <- run_umap_fig(data,data.labels,5,0.1)
fig2 <- run_umap_fig(data,data.labels,50,0.1)
fig3 <- run_umap_fig(data,data.labels,100,0.1)
fig4 <- run_umap_fig(data,data.labels,200,0.1)




library(plotly)

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2) %>%
  layout(plot_bgcolor='#e5ecf6', 
         xaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'), 
         yaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'))
png("umap_min_dist_0.1.png",height = 2500, width= 2500,res = 200)
fig
dev.off()



# 3-D plot

data.umap = umap(data, n_components = 3, n_neighbors = 50, min_dist = 0.1, random_state = 15,) 
layout <- data.umap[["layout"]] 
layout <- data.frame(layout) 
final <- cbind(layout, data.labels) 

fig5 <- plot_ly(final, x = ~X1, y = ~X2, z = ~X3, color = ~as.character(data.labels), colors = c('#636EFA','#EF553B','#00CC96')) 
fig5 <- fig5 %>% add_markers() 
fig5 <- fig5 %>% layout(scene = list(xaxis = list(title = '0'), 
                                     yaxis = list(title = '1'), 
                                     zaxis = list(title = '2'))) 

fig5


