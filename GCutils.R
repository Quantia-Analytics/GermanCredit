## Reference data and utility functions for analysis of the 
## German credit data. 

## Function to convert numeric variable to factor.
quantize.num <- function(x, nlevs = 5, maxval = 1000, 
                         minval = 0, ordered = TRUE){
  cuts <- seq(min(x), max(x), length.out = nlevs + 1)
  cuts[1] <- minval
  cuts[nlevs + 1] <- maxval
  x <- cut(x, breaks = cuts, order_result = ordered)
}

## Descriptive names for the columns of the dataset.
colNames <- c("CheckingAcctStat",
              "Durration",
              "CreditHistory",
              "Purpose",
              "CreditAmount",
              "SavingsBonds",
              "Employment",
              "InstallmentRatePecnt",
              "SexAndStatus",
              "OtherDetorsGuarantors",
              "PresentResidenceTime",
              "Property",
              "Age",
              "OtherInstalments",
              "Housing",
              "ExistingCreditsAtBank",
              "Job",
              "NumberDependents",
              "Telephone",
              "ForeignWorker")

## Column names including the transformed columns
colNames2 <- append(colNames, c("Durration_f", "CreditAmount_f", "Age_f"))

## Anaomouns functions to test the types in
## each of the columns in the dataset.
colTypes <- list(function(x) is.character(x), # CheckingAcctStat
                 function(x) is.numeric(x), # Durration
                 function(x) is.character(x), # CreditHistory
                 function(x) is.character(x), # Purpose
                 function(x) is.numeric(x), # CreditAmount
                 function(x) is.character(x), # SavingsBonds
                 function(x) is.character(x), # Employment
                 function(x) is.numeric(x), # InstallmentRatePecnt
                 function(x) is.character(x), # SexAndStatus
                 function(x) is.character(x), # OtherDetorsGuarantors
                 function(x) is.numeric(x), # PresentResidenceTime
                 function(x) is.character(x), # Property
                 function(x) is.numeric(x), # Age
                 function(x) is.character(x), # OtherInstalments
                 function(x) is.character(x), # Housing
                 function(x) is.numeric(x), # ExistingCreditsAtBank
                 function(x) is.character(x), # Job
                 function(x) is.numeric(x), # NumberDependents
                 function(x) is.character(x), # Telephone
                 function(x) is.character(x), # ForeignWorker
                 function(x) is.numeric(x) # CreditStatus
                 )


colTypes2 <- list(function(x) is.factor(x), # CheckingAcctStat
                 function(x) is.numeric(x), # Durration
                 function(x) is.factor(x), # CreditHistory
                 function(x) is.factor(x), # Purpose
                 function(x) is.numeric(x), # CreditAmount
                 function(x) is.factor(x), # SavingsBonds
                 function(x) is.factor(x), # Employment
                 function(x) is.numeric(x), # InstallmentRatePecnt
                 function(x) is.factor(x), # SexAndStatus
                 function(x) is.factor(x), # OtherDetorsGuarantors
                 function(x) is.numeric(x), # PresentResidenceTime
                 function(x) is.factor(x), # Property
                 function(x) is.numeric(x), # Age
                 function(x) is.factor(x), # OtherInstalments
                 function(x) is.factor(x), # Housing
                 function(x) is.numeric(x), # ExistingCreditsAtBank
                 function(x) is.factor(x), # Job
                 function(x) is.numeric(x), # NumberDependents
                 function(x) is.factor(x), # Telephone
                 function(x) is.factor(x), # ForeignWorker
                 function(x) is.factor(x) # CreditStatus
)

## Indicator if factor is ordered. 
isOrdered  <- as.logical(c(T,
                           F,
                           T,
                           F,
                           F,
                           T,
                           T,
                           F,
                           F,
                           T,
                           F,
                           T,
                           F,
                           T,
                           T,
                           F,
                           T,
                           F,
                           T,
                           T))

## Order of factors.
factOrder  <- list(list("A11", "A14", "A12", "A13"),
                   NA,
                   list("A34", "A33", "A30", "A32", "A31"),
                   NA,
                   NA,
                   list("A65", "A61", "A62", "A63", "A64"),
                   list("A71", "A72", "A73", "A74", "A75"),
                   NA,
                   NA,
                   list("A101", "A102", "A103"),
                   NA,
                   list("A124", "A123", "A122", "A121"),
                   NA,
                   list("A143", "A142", "A141"),
                   list("A153", "A151", "A152"),
                   NA,
                   list("A171", "A172", "A173", "A174"),
                   NA,
                   list("A191", "A192"),
                   list("A201", "A202"))


fact.set  <- function(inframe, metaframe){
  ## This function transforms the dataset to ensure
  ## factors are defined and to add descriptive column names.
  numcol <- ncol(inframe) - 1
  for(i in 1:numcol){
    if(!is.numeric(inframe[, i])){
        inframe[, i]  <- as.factor(inframe[, i])}
  }
  
  inframe[, 21] <- as.factor(inframe[, 21])
  colnames(inframe) <- c(as.character(metaframe[, 1]), "CreditStatus")
  inframe
}

fact.set2  <- function(inframe, metaframe){  
  ## This function transforms the dataset to ensure ordered
  ## factors are defined and to add descriptive column names.
  numcol <- ncol(inframe) - 1
  for(i in 1:numcol){
    if(!is.numeric(inframe[, i])){
      if(metaframe[i, 2]){
        inframe[, i]  <- ordered(inframe[, i], 
                                 levels = unlist(metaframe[i, 3]))
        #        inframe[, i]  <- as.factor(inframe[, i])
      }else{
        inframe[, i]  <- as.factor(inframe[, i])
      }
    }
  }
  
  inframe[, 21] <- as.factor(inframe[, 21]) 
  colnames(inframe) <- c(as.character(metaframe[, 1]), "CreditStatus")
  inframe
}


fact.set3  <- function(inframe, metaframe){
  ## This function transforms the dataset to ensure
  ## factors are defined and to add descriptive column names.
  numcol <- ncol(inframe) - 1
  for(i in 1:numcol){
    if(!is.numeric(inframe[, i])){
      inframe[, i]  <- as.factor(inframe[, i])}
  }
  inframe[, 21] <- as.factor(inframe[, 21]) 
  colnames(inframe) <- c(as.character(metaframe[, 1]), "CreditStatus")
  inframe
}



equ.Frame <- function(inframe, nrep){
  nrep <- nrep - 1
  ## Build the dataframe with equal numbers of positive and negative responses
  ## and convert column 21 to a factor.  
  if(nrep > 0){
    posFrame  <- inframe[inframe[,21] == 2, ]
    inframe <- data.frame(Map(function(x,y){c(x, rep(y, nrep))}, inframe, posFrame))
  }
  inframe
}

serList <- function(serlist){
  ## Function to serialize list of R objects and returns a dataframe.
  ## The argument is a list of R objects. 
  ## The function returns a serialized list with two elements.
  ## The first element is count of the elements in the input list.
  ## The second element, called payload, containts the input list.
  ## If the serialization fails, the first element will have a value of 0,
  ## and the payload will be NA.
  
  ## Messages to use in case an error is encountered.
  messages  <- c("Input to function serList is not list of length greater than 0",
                 "Elements of the input list to function serList are NULL or of length less than 1",
                 "The serialization has failed in function serList")
  
  ## Check the input list for obvious problems
  if(!is.list(serlist) | is.null(serlist) | length(serlist) < 1) {
    warning(messages[2])
    return(data.frame(as.integer(serialize(list(numElements = 0, payload = NA), connection = NULL))))}
  
  ## Find the number of objects in the input list.
  nObj  <-  length(serlist)
  
  ## Serialize the output list and return a data frame.
  ## The serialization and assignment are wrapped in tryCatch
  ## in case anything goes wrong. 
  tryCatch(outframe <- data.frame(payload = as.integer(serialize(list(numElements = nObj, payload = serlist), connection=NULL))),
           error = function(e){warning(messages[3])
                               outframe <- data.frame(payload = as.integer(serialize(list(numElements = 0, payload = NA), connection=NULL)))}
  )
  outframe
}

unserList <- function(inlist){
  ## Function unserializes a list of R objects
  ## which are stored in a column of a dataframe.
  ## The unserialized R objects are returned in a list.
  ## If the unserialize fails for any reason a value of
  ## NA is returned.
  
  ## Some messages to use in case of error. 
  messages <- c("The payload column is missing or not of the correct type",
                "Unserialization has failed in function unserList",
                "Function unserList has encountered an empty list")
  
  ## Check the input type.
  if(!is.integer(inlist$payload) | dim(inlist)[1] < 2 | 
       is.null(inlist$payload | inlist$numElements < 1)){
    warning(messages[1]) 
    return(NA)
  }
  
  ## Unserialized the list. The unserialize and assignment are
  ## wrapped in tryCatch in case something goes wrong. 
  tryCatch(outList <- unserialize(as.raw(inlist$payload)),
           error = function(e){warning(messages[2]); return(NA)})
  
  ## Check if the list is empty, which indicates something went 
  ## wrong with the serialization provess.
  if(outList$numElements < 1 ) {warning(messages[3]); return(NA)}
  
  outList$payload
}

