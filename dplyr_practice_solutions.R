# dplyr practice with "Seatbelts" data

# objective: Get practice with common dplyr functions 
# and familiarize with dplyr workflow

################################################
# STEP 1: install and load dplyr
################################################

# install package only if don't have
if(!require(dplyr)){install.packges("dplyr")}
library(dplyr) 

# TODO: After loading dplyr, do you see any messages 
# about objects being "masked?" What does this mean?


################################################
# STEP 2: Load dataset
################################################

# TODO: Go to Kaggle link (included below) and do the following:
# What is the dataset about? When and where was this data collected?
# What is a row?
# What is a column? Which 2 columns store data about alcohol consumption?
# How might somebody want to use this data?
# Link to dataset: https://www.kaggle.com/uciml/student-alcohol-consumption

# TODO: Download the data (you'll need to create an account) and store 
# "student-mat.csv" in the `data/` directory. (Ignore the other files)

# TODO: read the data from data/student-mat.csv into a variable `df`
# handle strings so they are not factors
# You may need to set the working directory first
df <- read.csv("data/student-mat.csv", stringsAsFactors = FALSE)

# TODO: View the dataset. Is it what you expect? Is there missing data?
View(df)

################################################
# STEP 3: Analyze data
################################################

# TODO: select columns related to age, address, weekday consumption,
# weekend consumption, and number of absences. Store these 5 columns in
# a variable named `df_select`.
df_select <- df %>% dplyr::select(age, address, Dalc, Walc, absences)

# TODO: filter dataframe to only get students in rural areas and store in 
# variable `df_rural`. How many responses are from students in rural areas?
df_rural <- df %>% dplyr::filter(address == "R")
nrow(df_rural) # 88

# TODO: Use mutate() the dataframe df to include a new column "total_alc" which is 
# the sum of weekday and weekend consumption ratings. 
# Be sure to update `df` to include this column
df <- df %>% mutate(total_alc = Dalc + Walc)

# TODO: arrange() student responses from lowest to highest by total consumption
# View the results
View(df %>% arrange(total_alc))

# TODO: arrange() student responses from oldest to youngest
# Tip: add a `-` before a column name to sort it in descending order
View(df %>% arrange(-age))

# TODO: Use summarize() to get average/mean absences (as variable `avg_absences``)
# and median age (as variable `median_age`)
df %>% summarize(avg_absences = mean(absences), median_age = median(age))

# TODO: Use group_by() to Group students by sex and age
# then use summarize to get the following summary information:
# - mean_alc: mean total alcohol rating
# - mean_absences: mean number of absences
# - frequency: number of responses in that group (using function `n()`)
# View the results
output <- df %>% group_by(sex, age) %>% 
  summarize(mean_alc = mean(total_alc), 
            mean_absences = mean(absences),
            freq = n())

View(output)
