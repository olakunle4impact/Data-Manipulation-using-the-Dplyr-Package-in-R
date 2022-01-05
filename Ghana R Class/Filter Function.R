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
