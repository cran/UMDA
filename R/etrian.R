etrian <- function(X, lowconver=FALSE){
  if(is.vector(X)) X <- matrix(X, ncol=1)
  mins<-apply(X, 2, min, na.rm = TRUE)
  maxs<-apply(X, 2, max, na.rm = TRUE)
  means<-apply(X,2,mean, na.rm = TRUE)
  moda<-3*means-mins-maxs
  l1 <- moda - mins
  l2 <- maxs - moda

  if(lowconver){
    lim_inf <- mins - 0.05 * l1
    lim_sup <- maxs + 0.05 * l2
  }else{
    lim_inf <- mins
    lim_sup <- maxs
  }

  for(i in 1:length(lim_inf)) {
    if(abs(lim_sup[i] - lim_inf[i]) < 1e-12) {
      lim_inf[i] <- lim_inf[i] - 1e-11
      lim_sup[i] <- lim_sup[i] + 1e-11
    }
  }
  moda<- ifelse(moda<lim_inf|moda>lim_sup,(lim_inf+lim_sup)/2,moda)
  return(list(a=lim_inf, b=lim_sup,c=moda))
}
