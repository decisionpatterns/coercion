% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tf_check.R
\name{tf_check}
\alias{tf_check}
\alias{tf_check.default}
\alias{tf_check.atomic}
\alias{tf_check.data.frame}
\alias{tf_check.tf_try}
\alias{tf_pass}
\alias{format.tf_check}
\title{Check transform}
\usage{
tf_check(data, expr, key, ...)

\method{tf_check}{default}(data, expr, key, ...)

\method{tf_check}{atomic}(data, expr, key, .all)

\method{tf_check}{data.frame}(data, expr, key = TRUE, ...)

\method{tf_check}{tf_try}(data, expr, key = TRUE, ...)

tf_pass(...)

\method{format}{tf_check}(x, all = FALSE)
}
\arguments{
\item{data}{table of data to function as environment for \code{expr}}

\item{expr}{expression to evaluate}

\item{...}{arguments to \code{tf_check}
`}

\item{.all}{logical whether to display all the observation or
just the failed transformations. (Default: `FALSE``)}
}
\value{
A data.table with the result of the expression followed by the
names used from the columns
\itemize{
\item unexpected where one or more of the args are na
\item any missing
\item failures : no missing args,
}
}
\description{
Check transformation values
}
\details{
\code{format} formats a tf_check object; argument \code{all=TRUE} will show all
observations rather than those that fail`
}
\examples{
 
# Tables:
  
  data(iris) 
  setDT(iris)
  iris[ , Species := Species \%>\% as.character() ]

  iris \%>\% tf_check( Species \%>\% as.character() )
  iris \%>\% tf_check( Species \%>\% as.numeric()  )

  iris \%>\% setkey( Sepal.Length )
  iris \%>\% tf_check( Species \%>\% as.character(), .all=TRUE )
  
  iris \%>\% tf_pass( Species \%>\% as.character() )
  iris \%>\% tf_pass( Species \%>\% as.numeric()  )


x <- c(-2:2, NA) \%>\% 
  tf_try( sqrt ) \%>\% 
  tf_try( function(x) sqrt(x+1) ) 

tf_check(x)


Format: 
  


}
