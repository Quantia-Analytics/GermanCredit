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
  Credit <- maml.mapInputPort(1)
}

## Build a data frame from the reference data
metaFrame <- data.frame(colNames, isOrdered, I(factOrder))
  
## Create the ordered factors
Credit <- fact.set2(Credit, metaFrame)

## Compute the weighted random forest model.
require(C50)
Cost <- matrix(c(0, 5, 1, 0), nrow = 2, dimnames = list(c("1", "2"), c("1", "2")))
rfModel2  <- C5.0(CreditStatus ~ CheckingAcctStat
                    + Durration_f
                    + Purpose
                    + CreditHistory
                    + SavingsBonds
                    + Employment
                    + CreditAmount_f
                    + Employment, 
                    data = Credit,  
                  trials = 100, cost = Cost)

## Serialize the model object.
outFrame <- serList(list(credit.model = rfModel2, 
                         Attributes = attributes(rfModel)))

## Output the serialized model data frame
if(Azure) maml.mapOutputPort("outFrame")

