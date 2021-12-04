
# #need numeric vector for squeeze var
#
# #get model for every probe
# moddy = lapply(1:10, function(x)
#   lm(beta_1[x,]~as.factor(pheno_2[,1])))
# moddy
# sigma(moddy)
# moddysumm = lapply(1:10, function(x)
#   summary(lm(beta_1[x,]~as.factor(pheno_2[,1]))))
# moddysumm[[1]]$coefficients[2,"Std. Error"]
#
# #get sigma from each model
# siggys = lapply(moddy,sigma) #get summary for each linear model
# siggys = as.numeric(unlist(siggys))
# siggys^2
#
# #get residuals for each model
# resids = lapply(moddy,df.residual) #get summary for each linear model
# resids = as.numeric(unlist(resids))
# resids
# #8 = 10-2 n=10 samples - 2 params
#
# #get coefficients per row
# coefs = lapply(moddysumm, function(x) x$coefficients[,c(1)]) #get coefficients for each model
# coefs
# coefvecco <- as.numeric(unlist(lapply(coefs,'[', 2)))
# coefvecco
#
# #get SEs per probe
# probeys = lapply(moddysumm, function(x) x$coefficients[2,"Std. Error"]) #get Se for each model
# probeys =  as.numeric(unlist(probeys))
# probeys
# moddysumm[[10]]$coefficients[2,"Std. Error"]
#
#
# library(limma)
# out <- squeezeVar(siggys^2, resids, covariate=pheno_2[,1])
# out
# #df.prior = inf?
# #https://support.bioconductor.org/p/91413/
#
# out$t <- k$coefficients / testo$stdev.unscaled / sqrt(out$var.post)
# #out$t_try <- k$coefficients[2]/((out$var.post)*sqrt((1/5) + (1/5)))
# out$t_try <- k$coefficients[2]/(out$var.post*SE[2])
# out$t_try_again <- coefvecco/(out$var.post*probeys)
# out$t_try_again
#
# -0.365/(0.16*0.0965)
#
# #out$t <- coefficients / stdev.unscaled / sqrt(out$var.post)
# df.total <- df.residual + out$df.prior
# #problem: df.prior = infinitity and don't know why
# #df.pooled <- sum(k$df.residual,na.rm=TRUE)
# #df.total <- pmin(df.total,df.pooled)
# out$df.total <- df.total
# out$p.value <- 2*pt(-abs(out$t),df=df.total)
# out$p.value_t_try <- 2*pt(-abs(out$t_try_again),df=df.total)
#
# out$p.value_t_try_2 <- 2*pt(-abs(out$t_try_again),df=8)
# out
# out$p.value_t_try_2
# out$var.post
# k$coefficients[2]
# -0.3615/(0.09646*0.02326042)
