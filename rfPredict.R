
## Change the name of the data frame with the model.
modelFrame <- outFrame

## Build a data frame from the reference data
metaFrame <- data.frame(colNames, isOrdered, I(factOrder))

## Function to compute and output the predicted values
## from the random forest model. 
predict.RFmodel2 <- function(Credit, metaFrame){

## Create the factors
  Credit2 <- fact.set(Credit, metaFrame)

## Extract the model from the serialized input and assign 
## to a convenient name. 
  modelList <- unserList(modelFrame)
  rfModel <- modelList$rfModel

## Create a data frame to compare actual and predicted values
## for the test dataset for the model. 
  library(randomForest)
  library(C50)
  outFrame <- data.frame( Actual = Credit2$CreditStatus,
                        Scored = predict(rfModel, newdata = Credit2))
}

outFrame <- predict.RFmodel2(Credit, metaFrame)


