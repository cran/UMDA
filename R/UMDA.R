UMDA <- function(fn, lower, upper, n, d, iter=100, dist=c("norm","tri","hist","unif"), eeea=TRUE,lowconver=FALSE){
  population <- matrix(0, nrow=n, ncol=d) # poblacón inicial de ceros

  if (length(lower) == 0) lower <- -Inf
  if (length(upper) == 0) upper <- Inf            #arregla problemas de dimensionalidad con vectores

  lower <- c(lower, rep(tail(lower, 1), max(0, d - length(lower))))[1:d]
  upper <- c(upper, rep(tail(upper, 1), max(0, d - length(upper))))[1:d]

  #se pregunta si usar metodo eeea para generacion de P.inicial
  if(eeea){
    res<-ExplicitExploration(fun=fn,lower=lower,upper=upper,n=n,maxiter=iter/5,k=5,tolerance=0.01)
    population<-res$par
  }else{
    for(i in 1:d){
      population[, i] <- runif(n=n, min=lower[i], max=upper[i]) #llenado aleatorio de la matriz inicial en caso de no EEEA
    }
  }
  dist <- tryCatch(
    match.arg(dist),
    error = function(e) {
      warning("Distribution '", dist, "' not recognized. 'norm' will be used by default.")
      return("norm")
    }
  )
  #Eleccion de cual modelo usar
  if(dist=="norm"){
    for(k in 1:iter){
      fitness <- apply(population, 1, fn)
      # evaluamos la pob. inicial en la funcion objetivo a optimizar
      sorted_indices <- order(fitness)                           # vemos en que sorted_indices estan los mejores individuos
      selected_population <- population[sorted_indices[1:round(n/2)], ] # seleccionamos a los mejores individuos
      means <- apply(selected_population, 2, mean)                # sacamos means por columnas
      standard_deviations <- apply(selected_population, 2, sd)            # sacamos sd por columnas
      for(i in 1:d){
        population[, i] <- rnorm(n=n, mean=means[i], sd=standard_deviations[i])
        # calculamos las probabilidades por columna en base a la distribucion normal
      }
    }
  }else if(dist=="tri"){
    #diff<- matrix(1,nrow = iter,ncol = d)
    for(k in 1:iter){
      fitness <- apply(population, 1, fn)
      # evaluamos la pob inicial en la funcion objetivo a optimizar
      sorted_indices <- order(fitness)                           # vemos en que sorted_indices estan los mejores individuos
      selected_population <- population[sorted_indices[1:round(n/2)], ]
      parameters <- etrian(selected_population,lowconver = lowconver)
      #diff[k,]<- parameters$b-parameters$a
      for(i in 1:d){
        population[,i] <- rtrian(n=n,a=parameters$a[i],b=parameters$b[i],c=parameters$c[i])
      }
    }
  }else if(dist=="hist"){
    for(k in 1:iter){
      fitness <- apply(population, 1, fn)
      sorted_indices <- order(fitness)
      selected_population <- population[sorted_indices[1:round(n/2)], ]
      for(i in 1:d){
        population[, i] <- rhist(hist(selected_population[, i],plot=FALSE))
      }
    }

  }else if(dist=="unif"){
    #diff<- matrix(1,nrow = iter,ncol = d)
    for(k in 1:iter){
      fitness <- apply(population, 1, fn)
      sorted_indices <- order(fitness)
      selected_population <- population[sorted_indices[1:round(n/2)], ]
      for(i in 1:d){
        rango <- max(selected_population[, i]) - min(selected_population[, i])
        # Estimamos los parámetros (mínimo y máximo) de la variable ia partir de los individuos selected_population
        if(lowconver){
          min_val <- min(selected_population[, i]) - (0.01 * rango)
          max_val <- max(selected_population[, i]) + (0.01 * rango)
        }else{
          min_val <- min(selected_population[, i])
          max_val <- max(selected_population[, i])
        }
        # 2. Generamos la nueva población muestreando de esa distribución uniforme
        #diff[k, i] <- max_val - min_val
        population[, i] <- runif(n = n, min = min_val, max = max_val)
      }
    }
  }
  return(list(par=selected_population, value=fitness[sorted_indices],Model=dist))
  # Regresamos al mejor individuo y el mejor valor según la función a optimizar, y la distribucion usada
}
#
# #prueba de la funcion umda
#
# asda=UMDA(fn= sphere, lower =-200,upper=-100 ,n=500, d=2, iter=20,dist="unif",eeea = F,lowconver = F)
# asda2=UMDA(fn= sphere, lower =-200,upper=-100 ,n=500, d=2, iter=20,dist="unif",eeea = T,lowconver = T)
# asda3=UMDA(fn= sphere, lower =-200,upper=-100 ,n=500, d=2, iter=20,dist="unif",eeea = F,lowconver = T)
# asda4=UMDA(fn= sphere, lower =-200,upper=-100 ,n=500, d=2, iter=20,dist="unif",eeea = T,lowconver = F)
# v=1
# plot(1:nrow(asda$diff), asda$diff[,v],
#      type = "b",           # "b" dibuja puntos y líneas a la vez
#      col = "black",
#      pch = 16,             # Forma del punto (círculo relleno)
#      xlab = "Iteraciones",
#      ylab = "Diferencia (diff[,1])",
#      main = "Comparativa de Convergencia: unif, sphere",
#      ylim = range(c(asda$diff[,v], asda2$diff[,v]))) # Ajusta el eje Y para que entren ambos
#
# # 2. Añadir el segundo resultado (Sphere) en rojo
# lines(1:nrow(asda2$diff), asda2$diff[,v],
#       type = "b",
#       col = "red",
#       pch = 17)            # Forma del punto (triángulo)
# lines(1:nrow(asda3$diff), asda3$diff[,v],
#       type = "b",
#       col = "green",
#       pch = 8)
# lines(1:nrow(asda4$diff), asda4$diff[,v],
#       type = "b",
#       col = "purple",
#       pch = 11)
#
# # 3. Añadir una leyenda para identificar cada uno
# legend("topright",
#        legend = c("UMDA (FF)","UMDA (TT)","UMDA (FT)","UMDA (TF)"),
#        col = c("black", "red","green", "purple"),
#        pch = c(16, 17,8,11),
#        lty = 1)
#
