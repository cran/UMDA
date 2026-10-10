#simula datos de una distribucion con base a un histograma
rhist <- function(histogram){
  # Toma los datos del histograma
  intervals <- histogram$breaks
  frecuencies <- histogram$counts
  n_samples <- sum(frecuencies)

  #Calcular probabilidades de cada intervalo
  probabilities <- frecuencies / sum(frecuencies)
  n_intervals <- length(frecuencies)

  #Elegir aleatoriamente qué intervalo le toca a cada simulación
  intervals_index <- sample(1:n_intervals, size = n_samples, replace = TRUE, prob = probabilities)

  #Generar el valor continuo dentro del intervalo seleccionado
  simulated_data <- sapply(intervals_index, function(i) {
    runif(1, min = intervals[i], max = intervals[i+1])
    })
  return(datos=simulated_data)
}

