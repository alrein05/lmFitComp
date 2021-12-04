# lmFitComp
Overview
The lmFitComp package contains a function called lmFitComp that implements single-site linear regression for DNA methylation data and allows easy comparison of results to lmFit results from the limma package in Bioconductor.
It was developed as a sanity check mechanism as my current research involves using the lmFit function to identify CpG sites across the genome that are differentially methylated. I needed a function that would allow me to easily compare the number of significant hits that result when using classical linear regression, relative to the methods of lmFit, which employs generalized or weighted least squares and is often accompanied by a Bayesian method that creates moderated t-statistics.


Functions
1. lmFitComp() = takes a beta matrix and phenotype dataframe and returns the number of hyper-methylated (Up), hypo-methylated (Down), and non-significant (Not_sig) CpG sites for a given covariate of interest based on a FDR p-value threshold of 0.05. It also returns the log fold change, t-statistic, p-value and adjusted p-value for every CpG site. 


Installation
devtools::install_github("alrein05/lmFitComp")

Additional Notes:
Ensure that the order of the samples in the phenotype data frame and the beta matrix is the same.
