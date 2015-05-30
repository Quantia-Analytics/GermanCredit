## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Source the zipped reference data
  source("src/GCutils.R")
  ## Read the input data table into a data frame. 
  Credit <- maml.mapInputPort(1)
}

## Make factors/categorical variables 
## from some numeric variables
toFactors <- c("Duration", "CreditAmount", "Age")
facNames <- unlist(lapply(toFactors, function(x) paste(x, "_f", sep = "")))
cuts <- list(one = c(0.0, 17.6, 31.2, 44.8, 58.4, 100.0),
             two = c(0.0, 3884.8, 7519.6, 11154.4 , 14789.2, 1000000.0),
             three = c(0.0, 30.2, 41.4, 52.6, 63.8, 100.0))
Credit[, facNames] <- Map(function(x, y) cut(Credit[, x], breaks = y, order_result = TRUE),
                          toFactors, cuts)

## Output the result as an Azure ML table
if(Azure) maml.mapOutputPort('Credit')