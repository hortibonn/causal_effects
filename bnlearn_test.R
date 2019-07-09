#test of the hill climbing 'greedy' bn with bnlearn
#Tsamardinos, Ioannis, Laura E. Brown, and Constantin F. Aliferis. “The max-min hill-climbing Bayesian network structure learning algorithm.” Machine learning 65.1 (2006): 31-78.

library(bnlearn)

data(coronary)

#create the network ####
bn_df <- data.frame(coronary)
#(structure finding creates conditional dependency)
#quick and dirty
#use hc options (i.e. start) for describing DAC
res <- hc(bn_df) #max-min hill climbing from 
plot(res)

#remove the link between M.Work and Family

res$arcs <- res$arcs[-which((res$arcs[,'from'] == 
            "M..Work" & res$arcs[,'to'] == "Family")),]
plot(res)

#bn.fit runs the ensemble EM algorithm to learn CPT
fittedbn <- bn.fit(res, data = bn_df)

print(fittedbn$Proteins)

#inferring from the network####
#chance that a non-smoker with pressure >140 has Protein level <3?

cpquery(fittedbn, event = (Proteins=="<3"), 
        evidence = ( Smoking=="no" & Pressure==">140" ) )

#Protein < 3, chance of Pressure > 140?
cpquery(fittedbn, event = (Pressure==">140"), 
        evidence = ( Proteins=="<3" ) )

