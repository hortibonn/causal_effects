#Using Judea Pearl's do-Calculus in R
#https://cran.r-project.org/web/packages/causaleffect/vignettes/causaleffect.pdf
#https://cran.r-project.org/web/packages/causaleffect/causaleffect.pdf

library(causaleffect)
library(igraph)

#even more complex model diagram
# simplify = FALSE to allow for multiple edges
f <- graph.formula(base_area -+ amount_lettuce, base_area -+ theoretical_production_area,
                   grow_levels -+ theoretical_production_area, theoretical_production_area -+ share_of_effective_area_per_theoretical_area,
                   theoretical_production_area -+ effective_production_area, share_of_effective_area_per_theoretical_area -+
                     effective_production_area, effective_production_area -+ grow_levels, 
                   effective_production_area -+ amount_lettuce, grow_levels -+ amount_lettuce, plants_per_sqm -+ amount_lettuce,
                   losses_due_quality -+ amount_lettuce, benefits -+ revenue_lettuce,
                   number_early_harvest -+ amount_lettuce, amount_lettuce -+ price_per_product,
                   price_per_product -+ yearly_benefits, yearly_benefits -+ benefits, staff_number -+ staff_salary,
                   costs -+ revenue_lettuce, staff_salary -+ yearly_costs, water -+ yearly_costs, electricity -+ yearly_costs, # defining costs
                   fertilizer -+ yearly_costs, interior_per_sqm -+ one_time_costs, base_area -+ rent_of_base_area,
                   rent_of_base_area -+ yearly_costs,  
                   need_building -+ yes, need_building -+ no, no -+ rent_of_base_area, yes -+ building_construction, 
                   grow_levels -+ one_time_costs, amount_lettuce -+ seed_plant_material_costs, seed_plant_material_costs -+ yearly_costs,
                   effective_production_area -+ light_panels, light_panels -+ one_time_costs, effective_production_area -+
                     plants_per_sqm, plants_per_sqm -+ growing_medium_costs,
                   growing_medium_costs -+ yearly_costs, amount_lettuce -+ packing_material, packing_material -+ yearly_costs,
                   probabilty_no_building -+ need_building, #scenario if building is needed
                   building_construction -+ construction_costs, construction_costs -+ one_time_costs, 
                   one_time_costs -+ costs, yearly_costs -+ costs, simplify = FALSE) 

#Plotting the first model draft
plot(f)

f <- set.edge.attribute(graph = f, name = "description", index = c(4,5), value = "U")
plot(f)

#Checking bayesian coherences between variables
model_VF <- causal.effect(y = "revenue_lettuce", x = c("amount_lettuce","staff_number"), z = NULL, G = f, expr =  TRUE)
                            #simp = TRUE, steps = TRUE, prune = TRUE)
cat(model_VF)
#Calculate this output?!

#Do a smaller model. Idea: Involve numbers and later ranges to calculate model output
test_model <- graph.formula(X -+ Y, X -+ A, A -+ Y, W -+ Y, V -+ W, A-+ W, V -+ X, B -+ A, B -+ X)
plot(test_model)

B <- rnorm(10, 4, 4)
plot(B)

V <- rnorm(10, 7, 3)
plot(V)

W <- rnorm(10, 8, 2)
plot(W)

X <- rnorm(10,5, 1)
plot(X)

Y <- rnorm(10,10, 3)
plot(Y)

A <- rnorm(10, 5, 3)
plot(A)

#Show bayesian coherences
test_model123 <- causal.effect(y = "Y", x = c("X"), z = NULL, G = test_model, expr =  TRUE, simp = TRUE)
cat(test_model123)

# Outcome: \sum_{B,V}P(Y|V,B,X)P(B)P(V)

# Set bidirected edges
g <- set.edge.attribute(test_model, "description", 5:6, "U")

# Construct set of available experimental data
s <- list(list(Z = c("Y"), A = c("X"), B = c("A"),  C  = c("V"), D = c("W"), E = ("B")))

surrogate.outcome(y = "Y", x = c("A"), S = s, G = test_model)

# Calculate it?!
# Solving the problem together by sharing knowledge 

# Outcome for G = g : \sum{B,A}P(Y|B,X,A)P(A|B,X)P(B) 
# Outcome for G = test_model
# Need to transform bayesian coherences of variables into equation that can calculate it
# using other functions to randomly select values out of defined variables?
# and then calculate


#using igraph####
#using igraph####
#https://kateto.net/netscix2016.html


