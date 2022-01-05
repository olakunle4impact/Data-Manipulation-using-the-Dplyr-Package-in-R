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
