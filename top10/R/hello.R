#' Building a Model with Top Ten Features
#'
#' This function develops a prediciton algorithm based on the top 10 features
#' in "x" that are most predictive of "y".
#'
#' @param x an n * p matrix of n observations and p predictors
#' @param y a vector of length n representing the response
#' @return a vector of the coefficients from the final fitted model with
#' top ten features
#' @author Peter Siw
#' @details
#' This function runs a univariate regression of y on each predictor in x and
#' calculates a p-value indicating the significance of the model with each
#' predictors. The final set of twn predictors are taken from the top ten
#' smallest p-values.
#' @seealso \code{lm}
#' @export
#' @importFrom stats lm

top10 <- function(x, y) {
  #x is the input matrix and y is the output vector
  p <- ncol(x)
  #check that p is greater than 10
  if(p < 10)
    stop("There are less than 10 predictors")
  pvalues <- numeric(p)
  for(i in seq_len(p)) {
    fit <- lm(y ~ x[, i])
    summ <- summary(fit)
    pvalues[i] <- summ$coefficients[2, 4]
  }
  ord <- order(pvalues)
  ord10 <- ord[, 10]
  x10 <- x[, ord10]
  fit10 <- lm(y ~ x10)
  coef(fit10)
}

#' Prediction with Top Ten Features
#'
#' This function takes a set of coefficients produced by the \code{top10}
#' function and makes a prediction for each of the values provided in the "X"
#' matrix.
#' @param X an n * 10 matrix containing n new observations
#' @param b a vector of the coefficients from the \code{top10} function
#' @return a numeric vector containing the predicted values
#' @export


pred10 <- function(X, b) {
  X <- cbind(1, X)
  drop(X %*% b)
}



