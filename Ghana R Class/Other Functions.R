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



