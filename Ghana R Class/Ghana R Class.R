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


#### 2. FILTER  ####
## BASE R APPROACH ##
perf[perf$gender == "female",]
perf[perf$gender == "female" & perf$lunch == "standard",]

### DPLYR APPROACH ##
filter(perf, gender == "female")
filter(perf, gender == "female", lunch =="standard")

## Can be used for the OR condition ##
filter(perf,race.ethnicity=="group A" | gender=="male")

## Can be used for the AND condition ##
filter(perf,race.ethnicity=="group A" & gender=="male")

## %in% function ##
filter(perf, race.ethnicity %in% c("group A","group C")) ## same as below ##
filter(perf,race.ethnicity=="group A" | race.ethnicity=="group C")

### 3. PIPE FUNCTION (%>%) ####

## NESTING ##
care<-filter(select(perf,math.score,reading.score), math.score>60)

ba<-perf%>%
  filter(math.score>60)%>%
  select(math.score,reading.score)

cad<-perf[perf$math.score>60,]
cad ## does the length of cad tallies with that of ba and care?
str(cad)
summary(cad) ## To see the five number summary


## PIPE/ CHAINING
perf %>%
  filter(gender =="male") %>%
  select(math.score,reading.score,writing.score)

## Let's create a new variable
perf_gender<- perf %>%
  filter(gender =="female")%>%
  select(math.score,reading.score)

## Example: Euclidean distance between x1 and x2 
x1<-1:5; x2<-2:6
sqrt(sum((x1-x2)^2))

(x1-x2)^2 %>% sum()%>% sqrt()

## 4. ARRANGE ##
## Base R Approach
perf[order(perf$lunch), c("race.ethnicity","lunch")]
## Let's see the effect using the table ()
table(perf[order(perf$lunch), c("race.ethnicity")])
table(perf[order(perf$lunch), c("race.ethnicity","lunch")])
table(perf[order(perf$lunch), c("race.ethnicity","lunch","gender")])

## DPLYR Approach ##
perf%>%
  select(race.ethnicity)%>%
  arrange(perf$lunch)%>%
  table()

perf%>%
  select(race.ethnicity,lunch)%>%
  arrange(lunch)%>%
  table()

perf%>%
  select("race.ethnicity","lunch","gender")%>%
  arrange(lunch)%>%
  table()

## The "desc" descending function ##
perf%>%
  select(race.ethnicity,lunch)%>%
  arrange(desc(lunch))%>%
  table()

### 5. MUTATE ###
## Creating a new column from exisiting column

## Base R Approach
perf$mean.scores <- (perf$math.score + perf$reading.score + perf$writing.score)/3

## DPLYR Approach ##
vae<-perf%>%
  mutate(mathsquare= (math.score+reading.score+writing.score)/3)%>%
  head()

## To store the new variable in PERF ##
vae<-perf%>% ## you can select if you want to ##
  select(math.score,reading.score,writing.score)%>%
  mutate(mathsquare= (math.score+reading.score+writing.score)/3)%>%
  head()

## You can use the print() to view your result## OR
vae%>%
  select(math.score,reading.score,writing.score,mathsquare)%>%
  head()

vae
  
## Example
perf%>%
  mutate(mathsquare =math.score^2)%>%
  head()

## For female Students alone ##
perf%>%
  mutate(mathfemale = math.score+5)%>%
  filter(gender =="female")%>%
  head()

## Imagine if a row in the perf datasets have an NA, e.g english.score
perf%>%
  mutate(mathfemale = math.score+5)%>%
  filter(!is.na(english.score))%>%
  head()

### 6. SUMMARISE ###
## Base R Approach ##
head(with(perf, tapply(math.score, race.ethnicity, mean, na.rm=T)))
head(aggregate(math.score~race.ethnicity, perf, mean))

## DPLYR Approach ##
ban<-perf%>%
  group_by(race.ethnicity)%>%
  summarise(meanMS= mean(math.score, na.rm=T))%>%
  head()

## Summarise_each ##
ban1<-perf%>%
  group_by(race.ethnicity)%>%
  summarise_each(funs(mean),reading.score, writing.score)%>%
  head()

## Example ##
ban2<-perf%>%
  group_by(race.ethnicity)%>%
  summarise_each(funs(min(., na.rm = T), max(., na.rm = T)), matches("score"))

## List argument ##
ban3<-perf%>%
  group_by(race.ethnicity)%>%
  summarise_each(list(mean=mean, median=median),reading.score, writing.score)%>%
  head()

## The n() takes the count ##
ban4<- perf%>%
  group_by(gender, race.ethnicity)%>%
  summarise(math.score =n())%>%
  arrange(desc(math.score))

ban5<- perf%>% ## This is same with the above except for the diff in column name
  group_by(gender, race.ethnicity)%>%
  tally(sort = T)

## n_distinct() ##
ban6<- perf%>%
  group_by(race.ethnicity)%>%
  summarise(math.score=n(), reading.score=n_distinct(reading.score))


### Gender grouped by race.ethnicity ##
perf%>%
  group_by(race.ethnicity)%>%
  select(gender)%>%
  table()%>%
  head()

### WINDOW FUNCTION ##
ban8<- perf%>%
  group_by(race.ethnicity)%>%
  select(gender, lunch, math.score)%>%
  filter(min_rank(desc(math.score)) <=2)%>%
  arrange(race.ethnicity, desc(math.score))

## OR
ban9<- perf%>%
  group_by(race.ethnicity)%>%
  select(gender, lunch, math.score)%>%
  top_n(2)%>%
  arrange(race.ethnicity, desc(math.score))

## The lag and Lead() ##
ban10 <- perf%>%
  group_by(race.ethnicity)%>%
  summarise(math.score=n())%>%
  mutate(change=math.score - lag(math.score)) ## Reference to the earlier value

ban11 <- perf%>%
  group_by(race.ethnicity)%>%
  tally()%>%  ## tally ()
  mutate(change=n - lag(n))

ban12 <- perf%>%
  group_by(race.ethnicity)%>%
  summarise(math.score=n())%>%
  mutate(change=math.score - lead(math.score)) ## reference to the next value

## Sample_n () ##
perf%>% sample_n(6) ## without replacement

## Sample_frac () ##
perf%>% sample_frac(0.20, replace = T) ## sample just 20% of the population

str(perf) ## Base R Approach
glimpse(perfr) ## DPLYR Approach

#### RENAME  #####
rename(perf, "breast" = "lunch") ## "new name" = "old name"



