#Using Jude Pearl's do-Calculus in R
#https://cran.r-project.org/web/packages/causaleffect/vignettes/causaleffect.pdf
#https://cran.r-project.org/web/packages/causaleffect/causaleffect.pdf

#using do-calculus ####
library(causaleffect)
library(igraph)

g <- graph.formula(Temp -+ chill)
plot(g)

g <- graph.formula(Temp +- chill) #reverse arow
plot(g)


g <- graph.formula(Temp -+ test, test -+ Temp, team -+ Temp, test -+ team)
plot(g)

g <- set.edge.attribute(graph = g, name = "description", index = 1:2, value = "U")
plot(g)

# simplify = FALSE to allow multiple edges
f <- graph.formula(W -+ Z, Z -+ X, X -+ Y, W -+ Y, # Observed edges
                   W -+ Y, Y -+ W, Z -+ Y, Y -+ Z, Z -+ X, X -+ Z, simplify = FALSE)
plot(f)

#using igraph####
#https://kateto.net/netscix2016.html


