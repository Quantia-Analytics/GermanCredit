## Read the dataframe with the actual and predicted values.
## This line will only work in Azure ML.
compFrame <- maml.mapInputPort(1)

## This code is for testing in RStudio only.
compFrame <- outFrame

Accurancy <- function(x){
    (x[1,1] + x[2,2]) / (x[1,1] + x[1,2] + x[2,1] + x[2,2])
  }

Recall <- function(x){  
    x[1,1] / (x[1,1] + x[1,2])
  }

Precision <- function(x){
  x[1,1] / (x[1,1] + x[2,1])
  }

F1 <- function(x){
  2 * x[1,1] / (2 * x[1,1] + x[1,2] + x[2,1])
}

## Compute the confusion matrix.
res.count <- matrix(unlist(Map(function(x, y){sum(ifelse(compFrame[, 1] == x & compFrame[, 2] == y, 1, 0) )},
                        c(2, 1, 2, 1), c(2, 2, 1, 1))), nrow = 2)

## Create a data frame with the output summary stats. 
mod2Conf <- data.frame( Category = c("Bad credit", "Good credit"),
                        Clasified_as_bad = c(res.count[1,1], res.count[2,1]),
                        Clasified_as_good = c(res.count[1,2], res.count[2,2]),
                        Accuracy_Recall = c(Accurancy(res.count), Recall(res.count)),
                        Precision_F1 = c(Precision(res.count), F1(res.count)))

## Output the data frame if operating in Azure ML.
maml.mapOutputPort('mod2Conf') 
