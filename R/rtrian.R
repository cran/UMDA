rtrian <- function(n, a, b, c) {
  # 1. Simulación matemática de los datos (Transformada inversa)
  if(c < a || c > b){

    c<-(a+b)/2
    warning("Mode away from limits, adjusting to the appropriate one")
  }
    u <- runif(n)
    f_c <- (c - a) / (b - a)
    datos <- ifelse(u < f_c,
                    a + sqrt(u * (b - a) * (c - a)),
                    b - sqrt((1 - u) * (b - a) * (b - c)))
    return(datos)
}

#hist(simular_triangular(5000,0,10,3)) #Ejemplo de uso
