## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Read the dataframe with the actual and predicted values.
  ## This line will only work in Azure ML.
  modelFrame <- maml.mapInputPort(1)
  creditTest <- maml.mapInputPort(2)
} else {
  modelFrame <- outFrame
  creditTest <- Credit
}

## Extract the model from the serialized input and assign 
## to a convenient name. 
modelList <- unserList(modelFrame)
credit.model <- modelList$credit.model

## Output a data frame with actual and values predicted 
## by the model.
#library(gam)
require(randomForest)
require(C50)
outFrame <- data.frame( actual = creditTest$CreditStatus,
                        scored = 
                          predict(credit.model, 
                                  newdata = creditTest))

## Output the data frame if operating in Azure ML.
if(Azure) maml.mapOutputPort('outFrame') 