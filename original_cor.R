library(readr)
temp_export <- read_csv("original_exp.csv")
View(temp_export)




# another method
library(readr)
setwd("C:/Users/Joseph Romero IV/OneDrive/Documents/Personal/Projects/music_o_set")

temp_table2 <- read_csv("temp_export.csv")
temp_table2 <- read_csv("temp_export.csv",
                        col_types = cols(duration_ms = col_double(),
                                         tempo = col_double(),
                                         popularity = col_double(),
                                         release_date_standard = col_date()))





# If df is your data frame containing the columns popularity and energy
corr <- cor(temp_export$popularity, temp_export$danceability, method = "pearson", use = "complete.obs")
print(corr)

