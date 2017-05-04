# Load package
library(networkD3)


# Create fake data
src <- c("A", "A", "A", "A",
         "B", "B", "C", "C", "D", "A")
target <- c("B", "C", "D", "J",
            "E", "F", "G", "H", "I","H")
networkData <- data.frame(src, target)

# Plot
tr <- make_tree(40, children = 3, mode = "undirected")
simpleNetwork(tr)

simpleNetwork(networkData)

#use for facebook, IMDB, rottentomatoe, 
# visualize network and check resources. 

plot(x=1:5, y=rep(5,5), pch=19, cex=12, col=rgb(.25, .5, .3, alpha=.5), xlim=c(0,6)) 

plot(x=1:10, y=rep(5,10), pch=19, cex=3, col="dark red")

points(x=1:10, y=rep(6, 10), pch=19, cex=3, col="557799")

points(x=1:10, y=rep(4, 10), pch=19, cex=3, col=rgb(.25, .5, .3))



library(igraph)
g1 <- graph(edges = c(1,2,2,3,3,1), n=3, directed=F)
plot(g1)



g4 <- graph( c("John", "Jim", "Jim", "Jack", "Jim", "Jack", "John", "John"), 
             
             isolates=c("Jesse", "Janis", "Jennifer", "Justin") )  

# In named graphs we can specify isolates by providing a list of their names.



plot(g4, edge.arrow.size=.5, vertex.color="gold", vertex.size=15, 
     
     vertex.frame.color="gray", vertex.label.color="black", 
     
     vertex.label.cex=0.8, vertex.label.dist=2, edge.curved=0.2) 




g4 <- graph( c("John", "Jim", "Jim", "Jack", "Jim", "Jack", "John", "John"), 
             
             isolates=c("Jesse", "Janis", "Jennifer", "Justin") )  

# In named graphs we can specify isolates by providing a list of their names.



plot(g4, edge.arrow.size=.5, vertex.color="gold", vertex.size=15, 
     
     vertex.frame.color="gray", vertex.label.color="black", 
     
     vertex.label.cex=0.8, vertex.label.dist=2, edge.curved=0.2) 


plot(graph_from_literal(a--+b, b+--c, a--+c, d--+a))


plot(graph_from_literal(a:b:c+--c:d:e))
E(g4)
V(g4)
g4[]
plot(g4)




er <- sample_gnm(n=100, m=40) 

plot(er, vertex.size=6, vertex.label=NA)  
