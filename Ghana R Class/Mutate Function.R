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
