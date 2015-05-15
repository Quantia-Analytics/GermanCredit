## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Source the zipped reference data
  source("src/reference.R")
  ## Install the c50 package from the zip file
  install.packages("src/C50_0.1.0-21.zip", lib = ".", repos = NULL, verbose = TRUE)
  ## Read in the training dataset. 
  Credit2 <- maml.mapInputPort(1)
}

## Function to create the weighted random forest model
create.RFmodel2 <- function(Credit, metaframe){

## Create the ordered factors
  Credit2 <- fact.set2(Credit, metaFrame)

## Compute the weighted random forest model.
  require(C50)
  Cost <- matrix(c(0, 5, 1, 0), nrow = 2, dimnames = list(c("1", "2"), c("1", "2")))
  rfModel2  <- C5.0(CreditStatus ~ ., data = Credit, 
                  trials = 100, cost = Cost)

## Serialize the model object.
  serList(list(credit.model = rfModel2, Attributes = attributes(rfModel)))
}

## Build a data frame from the reference data
metaFrame <- data.frame(colNames, isOrdered, I(factOrder))

## Call the function to compute the model.
outFrame <- create.RFmodel2(Credit2, metaframe)

## Output the serialized model data frame
if(Azure) maml.mapOutputPort("outFrame")

