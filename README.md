# lmFitComp
Overview
The lmFitComp package contains a function called lmFitComp that implements single-site linear regression for DNA methylation data and allows easy comparison of results to lmFit results from the limma package in Bioconductor

Functions
1. lmFitComp() = takes a beta matrix and phenotype dataframe and returns the number of hyper-methylated (Up), hypo-methylated (Down), and non-significant (Not_sig) CpG sites based on a FDR p-value threshold of 0.05

