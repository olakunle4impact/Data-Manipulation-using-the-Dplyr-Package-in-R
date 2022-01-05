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
