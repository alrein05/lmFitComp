#' lmFitComp
#'
#' Takes a beta matrix of methylation data, a phenotype data frame with variables of interest, and
#' a designation of which column number in the phenotype data contains the variable for which we
#' are investigating differential methylation. It returns the number of CpG sites in the genome that
#'  are hyper-methylated, hypo-methylated or not significant. Also returns per-probe log fold change,
#'  t-statistics, and p-values.
#'@param beta A matrix of beta-values between 0 and 1 with columns as samples and rows as probes
#'@param pheno A phenotype data frame containing variables of interest on samples. Must be ordered the same as beta matrix.
#'@param colNum An integer denoting the column number of the pheno data that contains the variable of interest
#'@return number of hypomethylated sites (down), insignificant sites, and hypermethylated sites (up) as well as the log fold change, t-statistic, p-values and adjusted p-values per probe
#'@examples lmFitComp(beta_matrix, phenotype_dataframe)
#'@import stats
#'@export
lmFitComp <- function(beta, pheno, colNum) {
#run linear regression model predicting methylation by a variable of interest
# for every probe in beta matrix
  models = lapply(1:nrow(beta), function(x)
    lm(beta[x,]~as.factor(pheno[,colNum])))


summs = lapply(models,summary) #get summary for each linear model
coefs = lapply(summs, function(x) x$coefficients[,c(1)]) #get coefficients for each model
tstats = lapply(summs, function(x) x$coefficients[2,c(3)]) #get coefficients for each model
p_vals =lapply(summs, function(x) x$coefficients[,c(4)]) # get p values for each model
p_adj = lapply(p_vals, function(x) p.adjust(x,method="fdr")) #get FDR-adjusted p values for each model

#get p-values as numeric vector
pvalvec <- as.numeric(unlist(lapply(p_vals,'[', 2)))
#adjusted p-vals as numeric vector
p_adjT <- p.adjust(pvalvec, method = "fdr")
#coefficients as numeric vector
coefvec <- as.numeric(unlist(lapply(coefs,'[', 2)))
t_stats <- as.numeric(unlist(tstats))

compdata <- data.frame(logFC=coefvec,
                       t=t_stats,
                       P.Value=pvalvec,
                       adj.P.Val=p_adjT)

sig_index = which(p_adjT < 0.05) #get indices of significant probes

Up=c()
Down=c()
Not_Sig=c()
if (length(sig_index)==0){
  Up=0
  Down=0
  Not_Sig= sum((p_adjT)>0.05)
} else {
  sig_probes=c()
  for (i in sig_index){
    sig_probes[i]=coefs[[i]][[2]]
  }

  Up =sum(sig_probes>0, na.rm=T)
  Down = sum(sig_probes<0, na.rm=T)
  Not_Sig= sum((p_adjT)>0.05)

}

#count and return the number of probes with FDR < 0.05 (significant hits showing differential methylation)
#return_list <- list(SigHits=sum((p_adjT)<0.05),
 #                   PropSig=sum((p_adjT)<0.05)/nrow(beta))
return_df <- rbind(Down,Not_Sig,Up)
retlist <- list(return_df, compdata)
return(retlist)

}
