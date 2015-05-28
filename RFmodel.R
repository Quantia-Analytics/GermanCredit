## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Assign a name to the dataset. 
  Credit <- dataset
}  

## Compute the random forest model and
## create the importance plot.
library(randomForest)
model <- randomForest( CreditStatus ~ CheckingAcctStat
                        + Duration_f
                        + Purpose
                        + CreditHistory
                        + SavingsBonds
                        + Employment
                        + CreditAmount_f
                        + Employment, 
                        data = Credit, 
                        ntree = 100, nodesize = 10)

