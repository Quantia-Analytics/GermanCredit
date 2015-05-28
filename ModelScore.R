## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Assign dataset to the new name
  Credit <- dataset
} 

## Output a data frame with actual and values predicted 
## by the model.
#library(gam)
require(randomForest)
scores <- data.frame( actual = Credit$CreditStatus,
                        scored = 
                          predict(model, 
                                  newdata = Credit))
 