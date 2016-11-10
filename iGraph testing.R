library(igraph)

g <- graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 4-6, 4-7, 5-6, 6-7)

V(g)  # vertices
E(g)  # edges
str(g)  # a more structured way to show edges
plot(g)

dg <- graph.formula(1-+2, 1-+3, 2++3)
plot(dg)
dg <- graph.formula(Sam-+Mary, Sam-+Tom, Mary++Tom)
str(dg)
V(dg)$name <- c("Sam", "Mary", "Tom")  # rename from vertices 123 to vertices sam mary tom

get.edgelist(dg)  # store edges in a two-column data frame
get.adjacency(g)  # store vertices and edges in matrix
get.adjacency(dg)

graph.adjlist
graph.edgelist
graph.adjacency
read.graph  # for data stored in a file
write.graph


# subgraph
h <- induced.subgraph(g, 1:5)  # g has vertices from 1 to 7. now subgraph only has vertices from 1 to 5
h <- g - vertices(c(6,7))  # same as above
h <- h + vertices(c(6,7))  # recover from h to g
g <- h + edges(c(4,6),c(4,7),c(5,6),c(6,7))  # same as above

# graph union
h1 <- h
h2 <- graph.formula(4-6, 4-7, 5-6, 6-7)
g <- graph.union(h1,h2)


# decorating the graph: vertices and edges
V(dg)$name
V(dg)$gender <- c("M","F","M")
V(g)$color <- "red"

# edge attributes can have discrete or continuous type
# edges can be equipped with weights
is.weighted(g)
wg <- g
E(wg)$weight <- runif(ecount(wg))
is.weighted(wg)

# using data frame

library(sand)
g.lazega <- graph.data.frame(elist.lazega, directed="FALSE", vertices=v.attr.lazega)
g.lazega$name <- "Lazega Lawyers"

vcount(g.lazega)
ecount(g.lazega)
list.vertex.attributes(g.lazega)

is.simple(g)  # simple graph: with no loop or multi-edge scenario
mg <- g + edge(2,3)
is.simple(mg)

E(mg)$weight <- 1
wg2 <- simplify(mg)  # converting mg from a multi-edge graph to a weighted graph
is.simple(wg2)
E(wg2)$weight

neighbors(g, 5)
degree(g)  # the number of edges incident on vertices
degree(dg, mode="in")
degree(dg, mode="out")











