% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hello.R
\name{pred10}
\alias{pred10}
\title{Prediction with Top Ten Features}
\usage{
pred10(X, b)
}
\arguments{
\item{X}{an n * 10 matrix containing n new observations}

\item{b}{a vector of the coefficients from the \code{top10} function}
}
\value{
a numeric vector containing the predicted values
}
\description{
This function takes a set of coefficients produced by the \code{top10}
function and makes a prediction for each of the values provided in the "X"
matrix.
}
