\name{etrian}
\alias{etrian}
\title{Estimation of Parameters of a Triangular Distribution
}

\description{
Empirically estimates the parameters a (minimum), b (maximum), and c (mode) of a triangular distribution based on a vector or matrix of observed data.
}

\usage{
etrian(X,lowconver)
}

\arguments{
  \item{X}{
    A numeric vector, matrix, or data frame containing the observed data. If a matrix or data frame is passed, the parameter estimation is performed independently for each column.
  }
  \item{lowconver}{
    Boolean flag to control convergence speed. \code{TRUE} slows down convergence by expanding the search space with wider intervals. \code{FALSE} uses standard estimation. Default is [\code{FALSE}].
    }
}


\details{
The function calculates the bounds using the empirical minimum (\code{a}) and the empirical maximum (\code{b}). To estimate the mode (\code{c}),it applies the standard formula: \eqn{c = 3 * \mu - a - b}.

The function includes several error-control safeguards:
\itemize{
  \item If a column has fewer than 2 data points or zero variance, it assigns the mean as the mode without using \code{density}.
  \item If extreme values are \code{NA} or infinite, the default values \code{a = -1, b = 1, c = 0} are assigned.
  \item If the difference between the maximum and minimum is less than \code{1e-5}, it slightly expands the limits (\code{1e-4}) to ensure mathematical stability.
  \item It ensures that the estimated mode \code{c} always remains within the strict range \code{[a, b]}.
}
}

\value{
Returns a list with three vector components:
  \item{a}{
  Estimated lower bound (estimated minimum).}
  \item{b}{
  Estimated upper bound (estimated maximum).}
  \item{c}{
  Estimated mode (point of maximum density).}
}

\references{
Kotz, S., & van Dorp, J. R. (2004). Beyond Beta: Other Continuous Families of Distributions with Bounded Support and Applications. World Scientific.
}

\author{
Rogelio Salinas Gutiérrez, Juan Alberto Dávila del Alto, Jhon Daniel Aguilar Payares, Jonathan Michell Jauregui Carranza, Hiram Efraim Macias Ruelas, Byron Axel Morales Gutiérrez, María Fernanda Nieto Guerrero, Manuel Alonso Segoviano Baltazar, Pedro Abraham Montoya Calzada.
}

\note{
If the data do not vary within a column, the function will fall back to the default behavior, assigning the mean as the estimated mode.
}

\seealso{
\code{\link{density}}, \code{\link{apply}}, \code{\link{min}}, \code{\link{max}}
}

\examples{
# --- Example of use ---
set.seed(123)
example_data <- rnorm(500,mean=38,sd=2)
result <- etrian(example_data)
print(result)
}

\keyword{ distribution }
\keyword{ robust }

