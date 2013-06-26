## This R script draws filled circles on the nodes of a phylogeny corresponding to the bootstrap
## support values. It has been adapted from the excellent book, "Analysis of Phylogenetics and 
## Evolution with R" by Emmanuel Paradis. 
## To handle posterior probablities from a MrBayes consensus file, either change the values in the p 
## matrix or use this handy bit to change the values to probabilities: 
## signif(as.numeric(bayesTree$node.label)*100, digits=2)

library(ape)
targetTree <- read.tree("bootTree.tre")

co <- c("black", "grey", "white")
p <- character(length(targetTree$node.label))
p[as.numeric(targetTree$node.label) >= 90] <- co[1]
p[as.numeric(targetTree$node.label) < 90 & as.numeric(targetTree$node.label) >= 70] <- co[2]
p[as.numeric(targetTree$node.label) < 70 | targetTree$node.label == ""] <- co[3]

## To plot a circle on all nodes:
plot(targetTree)
nodelabels(cex=0.75, bg=p, pch=21, frame="n")

## To plot a circle on only those nodes with good support (no white or unfilled circles):
plot(targetTree)
for(j in 1:Nnode(targetTree)) 
    {
        if(targetTree$node.label[[j]] != "" & as.numeric(targetTree$node.label[[j]]) > 70) 
        {
            nodelabels("", j+length(targetTree$tip.label), cex=0.75, bg=p[j], pch=21, frame="n")
        }
    }
