install.packages("tidyverse")
library(tidyverse)
install.packages("here")
library(here)
here() # shows project directory

read_csv(here("data", "Konsultasjoner.csv"))
myData <- read_csv2(here("data", "Konsultasjoner.csv"))
myData
head(myData, 10) # shows first 6 rows, or first n rows such as 10 here
view(myData) # should not be used for big data, it will crash R
summary(myData) # shows column information
glimpse(myData) # if many columns, checking first values of columns

skimr::skim(myData) # summary of statistics
naniar::gg_miss_var(myData) # for finding missing ata
#gg miss case which shows you how many rows are missing data
# $ accesses the elements of a list or data frame
myData$alder
#can use head to see the first values
#using pipe:
myData$alder %>%
  head()

myData %>%
  pivot_longer(
    names_to = "year",
    values_to = "nConsultations",
    cols = starts_with("Konsultasjoner")
  )

myData <- 
  myData %>%
  pivot_longer(
    names_sep = " ",
    names_to = c(NA, "year"),
    values_to = "nConsultations",
    cols = starts_with("Konsultasjoner")
  )

myData <-
  myData %>%
  rename(age = alder, 
         gender = kjoenn,
         diagnosis = diagnose) #new name = old name

myData

df %>%
  rename(drug312 = `312`)

myData %>%
  count(age)

myData %>%
  summarize(max(year), min(year)) # shows max and min year (2 columns)

#save tidy data
fileName <- paste0("tidy_consultation_", Sys.Date(), ".txt")
write_delim(myData,
            file = here("data", fileName), delim="\t") 
# not necessary to create variable fileName