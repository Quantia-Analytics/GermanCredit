## This code normally runs in Azure ML. By setting
## the variable Azure to False, the code will run 
## in R and RStudio.
Azure <- FALSE

if(Azure){
  ## Source the zipped reference data
  source("src/reference.R")
  ## Read in the training dataset. 
  Credit <- maml.mapInputPort(1)
}

## Explore imbalances between numbers of 
## factor categories both in tables and charts.

## Create a set of tables using CreditStatus
## as a grouping variable
library(dplyr)
lapply(colNames2, function(x) {
  if(is.factor(Credit[,x])){ 
    factCol <- list(as.symbol(x))
    Credit %>% 
      group_by_(.dots = factCol, "CreditStatus") %>%
      summarize(count = n())}})

## Some conditioned plots of the variables
## using ggplot2
library(ggplot2)
lapply(colNames2, function(x){
  if(is.factor(Credit[,x])) {
    ggplot(Credit, aes_string(x)) +
      geom_bar() + 
      facet_grid(. ~ CreditStatus) + 
      ggtitle(paste("Counts of good and bad credit by",x))}})

## Some plots conditioned on CreditStatus vs.
## the CheckingAcctStat variable.
lapply(colNames2, function(x){
  if(is.factor(Credit[,x]) & x != "CheckingAcctStat") {
    ggplot(Credit, aes(CheckingAcctStat)) +
      geom_bar() + 
      facet_grid(paste(x, " ~ CreditStatus"))+ 
      ggtitle(paste("Counts of good and bad credit by CheckingAcctStat and ",x))
  }})






