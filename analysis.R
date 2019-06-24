library(readxl)
library(dplyr)
library(reshape2)
library(ggplot2)
library(plotly)

# Reading in the data
wd <- getwd()
fileList <- list.files(paste(wd, "/data", sep = ""), pattern = ".xls")
e <- list()
e[[1]] <- read_excel("2007_Acc.xls", sheet = "7.9", skip = 2, n_max = 21) 
fileList_m <- fileList[2:10]
d <- lapply(fileList_m, read_excel, sheet = "7.9", skip = 1, n_max = 21)
f <- list()
f[[1]] <- read_excel("2017_Acc.xls", sheet = "7.8", skip = 1, n_max = 21)
full_list <- c(e, d, f)

# Extracting the accidents columns for every year into a data frame
acc <- data.frame(matrix(nrow = 21, ncol=11))
for(i in 1:length(full_list)){
  acc[,i] <- full_list[[i]][,2]
}

# Getting the row names (districts)
districts <- unlist(full_list[[1]][,1])
attr(districts, "names") <- NULL
districts <- sub("^[0-9]+[.][[:space:]]", "", districts)
rownames(acc) <- districts

# Setting the column names to the years
colnames(acc) <- 2007:2017

# Melting the data frame for easier plotting
acc <- mutate(acc, district = rownames(acc))
acc$district[acc$district=="No hi consta"] <- "Unknown"
acc_melted <- melt(acc, id = "district", measure.vars = c("2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"))
names(acc_melted) <- c("district", "year", "accidents")
acc_melted$district <- as.factor(acc_melted$district)


# Write the data frame into csv
write.csv(acc_melted, file = "acc.csv")





