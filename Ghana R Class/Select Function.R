### Think of every package as a book in your library
### When in need of them, you will have to go pick them at the library
## Same here. To use the "dplyr" package, you will call it from the 
## library of packages using the library
library(dplyr)
library(help="dplyr")
getwd()
setwd(dir = "C:/Users/````/Documents/GIS DataBase/RTest/Datasets")
perf<-read.csv("StudentsPerformance.csv") ## Dataset for practice
names(perf)

## Convert to local data frame ##
perfr<-tbl_df(perf)
data.frame(head(perfr))
print(data.frame(perfr))


## 1. SELECT  #####
## Base R Approach ##
perf[,c("gender","lunch")]

## DPLYR Approach ##
select(perf, gender, lunch)
## Takes in the dataframe and the amount of column you want to retain
select(perf,starts_with("lunch"),ends_with("math.score"))
## Its also possible you include some other column in between end and start argument
select(perf, ends_with("math.score"))

## Usage of : and "contains" ##
select(perf, gender:lunch, contains("score"))

## Usage of "matches" ##
select(perf, gender, matches("score"))

## use "-" to drop variables
select(perf, gender, -lunch, math.score)
## Select varaiants
select_all(perf)