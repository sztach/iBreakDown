% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotD3_break_down.R
\name{plotD3}
\alias{plotD3}
\alias{plotD3.break_down}
\title{Plot Break Down Objects in D3 with r2d3 package.}
\usage{
plotD3(x, ...)

\method{plotD3}{break_down}(x, ..., baseline = NA, max_features = 10,
  min_max = NA, vcolors = DALEX::theme_drwhy_colors_break_down(),
  digits = 3, rounding_function = round)
}
\arguments{
\item{x}{the model model of `break_down` class.}

\item{...}{other parameters.}

\item{baseline}{if numeric then veritical line will start in baseline.}

\item{max_features}{maximal number of features to be included in the plot. default value is 10.}

\item{min_max}{a range of OX axis. By deafult `NA` therefore will be extracted from the contributions of `x`. But can be set to some constants, usefull if these plots are used for comparisons.}

\item{vcolors}{named vector with colors.}

\item{digits}{number of decimal places (round) or significant digits (signif) to be used.
See the \code{rounding_function} argument.}

\item{rounding_function}{function that is to used for rounding numbers.
It may be \code{\link{signif}} which keeps a specified number of significant digits.
Or the default \code{\link{round}} to have the same precision for all components.}
}
\value{
an `r2d3` object.
}
\description{
Experimental interactive explainer created with 'D3.js' library.
}
\examples{
library("DALEX")
library("iBreakDown")
# Toy examples, because CRAN angels ask for them
titanic <- na.omit(titanic)
set.seed(1313)
titanic_small <- titanic[sample(1:nrow(titanic), 500), c(1,2,6,9)]
model_titanic_glm <- glm(survived == "yes" ~ gender + age + fare,
                       data = titanic_small, family = "binomial")
explain_titanic_glm <- explain(model_titanic_glm,
                           data = titanic_small[,-9],
                           y = titanic_small$survived == "yes")
bd_rf <- local_attributions(explain_titanic_glm, titanic_small[1, ])
bd_rf
plotD3(bd_rf)

\donttest{
library("randomForest")
titanic <- na.omit(titanic)
model_titanic_rf <- randomForest(survived == "yes" ~ gender + age + class + embarked +
                                   fare + sibsp + parch,  data = titanic)

explain_titanic_rf <- explain(model_titanic_rf,
                              data = titanic[,-9],
                              y = titanic$survived == "yes",
                              label = "Random Forest v7")

new_passanger <- data.frame(
  class = factor("1st", levels = c("1st", "2nd", "3rd", "deck crew", "engineering crew",
                                    "restaurant staff", "victualling crew")),
  gender = factor("male", levels = c("female", "male")),
  age = 8,
  sibsp = 0,
  parch = 0,
  fare = 72,
  embarked = factor("Southampton",
                  levels = c("Belfast", "Cherbourg", "Queenstown", "Southampton")))

  rf_la <- local_attributions(explain_titanic_rf, new_passanger)
  rf_la

  plotD3(rf_la)
  plotD3(rf_la, max_features = 3)
  plotD3(rf_la, max_features = 3, min_max = c(0,1))
}
}
\references{
Predictive Models: Visual Exploration, Explanation and Debugging \url{https://pbiecek.github.io/PM_VEE}
}
