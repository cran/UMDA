\name{UMDA}
\alias{UMDA}
\title{
Univariate Marginal Distribution Algorithm
}
\description{
Applies a Univariate Marginal Distribution Algorithm (UMDA) to
minimize an objective function. The algorithm iteratively selects the
best half of the population and generates a new population according
to a specified probability distribution.
}
\usage{
UMDA(fn,lower,upper,n,d,iter,dist,eeea,lowconver)
}
\arguments{
  \item{fn}{
    A function representing the objective function to be minimized.
    The function must receive a numeric vector which represents an
    individual and return a numeric fitness value.
  }

  \item{lower}{
    Lower bounds for the variables. A single numeric value can be
    provided and will be replicated across all \code{d} dimensions.
    Alternatively, a numeric vector of length \code{d} can be used.
  }

  \item{upper}{
    Upper bounds for the variables. A single numeric value can be
    provided and will be replicated across all \code{d} dimensions.
    Alternatively, a numeric vector of length \code{d} can be used.
  }

  \item{n}{
    The population size. Must be a positive integer indicating the
    number of individuals generated in each iteration.
  }

  \item{d}{
    The dimensionality of the optimization problem, corresponding to
    the number of variables in each individual.
  }

  \item{iter}{
    The number of generations or iterations of the algorithm, it must be
    provided.
  }

  \item{dist}{
    The probability distribution used to generate new individuals.
    Supported values are \code{"norm"} for the normal distribution,
    \code{"tri"} for the triangular distribution, \code{"hist"}
    for a histogram-based distribution, and \code{"unif"} for the
    uniform distribution. The default value is \code{"norm"}.
  }
  \item{eeea}{
    Selecte whether to use EEEA (Explicit Exploration Strategy for Evolutionary Algorithms) to generate the initial population (\code{TRUE} or \code{FALSE})
  }
  \item{lowconver}{
     Boolean flag to control convergence speed. \code{TRUE} slows down convergence by expanding the search space with wider intervals in each iteration. \code{FALSE} uses standard interval estimation. Default is \code{FALSE}."
  }
}
\details{
The UMDA is a population-based evolutionary optimization algorithm
that estimates the probability distribution of promising solutions
and uses this distribution to generate new candidate solutions.

The algorithm begins by generating an initial population uniformly
at random within the specified lower and upper bounds. At each
iteration, the objective function is evaluated for every individual
in the population. Individuals are then sorted according to their
fitness, and the best half of the population is selected.

The probability distribution of each variable is estimated
independently from the selected individuals. A new population is
then generated from these estimated distributions.

When \code{dist = "norm"}, the mean and standard deviation of each
variable are estimated from the selected individuals, and a new
population is generated using a normal distribution.

When \code{dist = "tri"}, the parameters of a triangular distribution
are estimated using the selected individuals. The new population is
then generated using the corresponding triangular distributions.

When \code{dist = "hist"}, a histogram is constructed for each
variable using the selected individuals. The histogram is then used
to simulate the values of the corresponding variable.

When \code{dist = "unif"}, the parameters of a uniform distribution
are estimated using the selected individuals. The new population is
then generated using the corresponding uniform distributions.

The algorithm assumes that lower objective function values represent
better solutions. Therefore, individuals are ordered in ascending
order according to their objective function value.
}
\value{
A list containing the best solution found during the final iteration
and its corresponding objective function value.

\item{par}{
A numeric vector containing the best individual selected in the final
iteration.
}

\item{value}{
A numeric value representing the objective function value of the best
individual in the final iteration.
}
\item{Model}{
Stadistical model used in the function, if none is selected, "norm" is used by default.
}
}
\references{
Larranaga, P. and Lozano, J. A. (2002).
Estimation of Distribution Algorithms: A New Tool for Evolutionary
Computation. Kluwer Academic Publishers.
}
\author{
Rogelio Salinas Gutiérrez, Juan Alberto Dávila del Alto, Jhon Daniel Aguilar Payares, Jonathan Michell Jauregui Carranza, Hiram Efraim Macias Ruelas, Byron Axel Morales Gutiérrez, María Fernanda Nieto Guerrero, Manuel Alonso Segoviano Baltazar, Pedro Abraham Montoya Calzada.
}
\note{
The function performs minimization. Therefore, the objective function
must return smaller values for better solutions.

The functions \code{etrian}, \code{rtrian}, and
\code{rhist} must be available in the R environment when using
the corresponding distribution options.

The initial population is generated uniformly within the specified
bounds. However, subsequent populations are generated from the
estimated distributions and are not explicitly restricted to the
original bounds.
}

\examples{
# Sphere objective function
sphere <- function(x) {
  return(sum(x^2))
}

# Run UMDA using a normal distribution
set.seed(123)

result <- UMDA(
  fn = sphere,
  lower = -50,
  upper = 50,
  n = 20,
  d = 2,
  iter = 100,
  dist = "norm",
  eeea =FALSE,
  lowconver=FALSE
)

# Best individual
result$par

# Best objective function value
result$value
}

\keyword{optimization}
\keyword{evolutionary}
\keyword{distribution}
