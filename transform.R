## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Source the zipped reference data
  source("src/GCutils.R")
  ## Read the input data table into a data frame. 
  Credit <- maml.mapInputPort(1)
}else{
  Credit <- read.csv("German Credit UCI.csv", header = F, stringsAsFactors = F )
  ## Build a data frame from the reference data
  metaFrame <- data.frame(colNames, isOrdered, I(factOrder))
  ## Adjust the number of data rows to there are approximately
  ## equal numbers in each category of the response.
  Credit <- fact.set(Credit, metaFrame)
}

## Create the factor variables and assign column names. 
Credit <- equ.Frame(Credit, 2)

## Make factors/categorical variables 
## from some numeric variables
toFactors <- c("Duration", "CreditAmount", "Age")
maxVals <- c(100, 1000000, 100)
facNames <- unlist(lapply(toFactors, function(x) paste(x, "_f", sep = "")))
Credit[, facNames] <- Map(function(x, y) quantize.num(Credit[, x], maxval = y),
                          toFactors, maxVals)

## Output the result as an Azure ML table
if(Azure) maml.mapOutputPort('Credit')