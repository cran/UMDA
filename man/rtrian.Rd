\name{rtrian}
\alias{rtrian}
\title{
Generate Random Values from a Triangular Distribution
}

\description{
Generates random values from a triangular probability distribution
using the inverse transform sampling method.
}

\usage{
rtrian(n, a, b, c)
}

\arguments{
  \item{n}{
    The number of random values to generate.
  }
  \item{a}{
    The lower bound of the triangular distribution.
  }
  \item{b}{
   The upper bound of the triangular distribution.
  }
  \item{c}{
    The mode of the triangular distribution, corresponding to the
    value where the probability density reaches its maximum.
  }
}

\details{
The function generates random values from a triangular distribution
defined by the lower bound \code{a}, upper bound \code{b}, and mode
\code{c}.

The random values are generated using the inverse transform sampling
method. First, a uniform random variable is generated using
\code{\link{runif}}. The value is then transformed according to the
cumulative distribution function of the triangular distribution.

For values below the cumulative probability at the mode, the function
uses the increasing part of the triangular distribution. For values
above this probability, the function uses the decreasing part.

The parameters must strictly satisfy \code{a < c < b}. If the estimated mode falls outside this range, \code{c} is automatically adjusted to the midpoint of the \code{[a, b]} interval.
}

\value{
Returns a numeric vector containing \code{n} randomly generated values from
the triangular distribution defined by \code{a}, \code{b}, and
\code{c}.
}

\references{
Kotz, S., & van Dorp, J. R. (2004). \emph{Beyond Beta: Other Continuous Families of Distributions with Bounded Support and Applications}. World Scientific.
}

\author{
Rogelio Salinas Gutiérrez, Juan Alberto Dávila del Alto, Jhon Daniel Aguilar Payares, Jonathan Michell Jauregui Carranza, Hiram Efraim Macias Ruelas, Byron Axel Morales Gutiérrez, María Fernanda Nieto Guerrero, Manuel Alonso Segoviano Baltazar, Pedro Abraham Montoya Calzada.
}

\note{
The function uses a uniform random number generator internally.
Therefore, the generated values depend on the random seed set by
\code{\link{set.seed}}.

The mode \code{c} must lie between the lower and upper bounds.
}

\examples{

set.seed(123)

# Generate 500 random values with min=0, max=10 and mode=5
simulated_values <- rtrian(n = 500, a = 0, b = 10, c = 5)

# See the results
head(simulated_values)

# Generate the histogram
hist(
  simulated_values,
  breaks = 20,
  col = "skyblue",
  border = "darkblue",
  main = paste("Histogram with the simulated values\n(n =", 500, ")"),
  xlab = "Values",
  ylab = "Frequency"
)
}

\keyword{distribution}
\keyword{random}
\keyword{simulation}
