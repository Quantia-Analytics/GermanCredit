## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Read the dataframe with the actual and predicted values.
  ## This line will only work in Azure ML.
  scoreFrame <- maml.mapInputPort(1)
  creditTest <- maml.mapInputPort(2)
} else {
  scoreFrame <- outFrame
  creditTest <- Credit
}

## Use dplyr to filter the missclassified rows.
require(dplyr)
creditTest <- cbind(creditTest, scored = outFrame$scored)
creditTest <- creditTest %>% filter(CreditStatus != scored)

## Plot the residuals for the levels of each factor
## variables
require(ggplot2)
colNames <- c("CheckingAcctStat", "Durration_f", "Purpose",
              "CreditHistory", "SavingsBonds", "Employment",
              "CreditAmount_f", "Employment")
lapply(colNames, function(x){
  if(is.factor(creditTest[,x])) {
    ggplot(creditTest, aes_string(x)) +
      geom_bar() + 
      facet_grid(. ~ CreditStatus) + 
      ggtitle(paste("Counts of good and bad credit by",x))}})


## Plot the residuals conditioned on CreditStatus vs.
## CheckingAcctStat.
colNames <- c("Durration_f", "Purpose", "CreditHistory", 
              "SavingsBonds", "Employment", 
              "CreditAmount_f", "Employment")
lapply(colNames, function(x){
  if(is.factor(creditTest[,x]) & x != "CheckingAcctStat") {
    ggplot(creditTest, aes(CheckingAcctStat)) +
      geom_bar() + 
      facet_grid(paste(x, " ~ CreditStatus"))+ 
      ggtitle(paste("Counts of good and bad credit by CheckingAcctStat and ",x))
  }})
