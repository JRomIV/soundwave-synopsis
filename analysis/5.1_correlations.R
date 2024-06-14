library(dplyr)

# import data
temp_attributes <- read.csv("temp_attributes.csv")

# create a correlation matrix
numeric_attributes <- select(temp_attributes, -song_name, -song_type, -release_date_standard, -song_id)
correlations <- cor(numeric_attributes, use = "everything", method = "pearson")

# export csv
write.csv(correlations,"correlations.csv")

