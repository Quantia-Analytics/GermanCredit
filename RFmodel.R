## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Source the zipped reference data, functions and packages
  source("src/GCutils.R")
  ## Read in the dataset. 
  Credit <- maml.mapInputPort(1)
}  

## Compute the random forest model and
## create the importance plot.
library(randomForest)
rf.mod <- randomForest( CreditStatus ~ CheckingAcctStat
                        + Durration_f
                        + Purpose
                        + CreditHistory
                        + SavingsBonds
                        + Employment
                        + CreditAmount_f
                        + Employment, 
                        data = Credit, 
                        ntree = 100, nodesize = 10)

outFrame <- serList(list(credit.model = rf.mod))

## Output the serialized model data frame
if(Azure) maml.mapOutputPort("outFrame")
