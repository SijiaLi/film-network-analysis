library(igraph)
g <- graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 4-6, 4-7, 5-6, 6-7)

V(g)  # vertice 
E(g)  # edges
str(g)  # a more structured way to show edges
plot(g)

dg <- graph.formula(1-+2, 1-+3, 2++3)
plot(dg)
dg <- graph.formula(Sam-+Mary, Sam-+Tom, Mary++Tom)
str(dg)

V(dg)$name <- c("Sam", "Mary", "Tom")  # rename from number 123 to name sam mary tom

get.edgelist(dg)
get.adjacency(g)
get.adjacency(dg)

graph.adjlist
graph.edgelist
graph.adjacency
read.graph  # for data stored in a file
write.graph







