#Using Judea Pearl's do-Calculus in R
#https://cran.r-project.org/web/packages/causaleffect/vignettes/causaleffect.pdf
#https://cran.r-project.org/web/packages/causaleffect/causaleffect.pdf

#using do-calculus ####
library(causaleffect)
library(igraph)

g <- graph.formula(Temp -+ chill)
plot(g)

g <- graph.formula(Temp +- chill) #reverse arrow
plot(g)

#more complex model diagram
g <- graph.formula(Temp -+ chill, chill -+ Temp, light -+ Temp, chill -+ light)
plot(g)

g <- set.edge.attribute(graph = g, name = "description", index = 1:2, value = "U")
plot(g)

#even more complex model diagram
# simplify = FALSE to allow for multiple edges
f <- graph.formula(chill -+ heat, heat -+ dormancy, dormancy -+ variety, chill -+ variety, # Observed edges
                   chill -+ variety, variety -+ chill, heat -+ variety, variety -+ heat, heat -+ dormancy, dormancy -+ heat, simplify = FALSE)
plot(f)

#using igraph####
#https://kateto.net/netscix2016.html


