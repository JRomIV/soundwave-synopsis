# import data
temp_table <- read.csv("C:/Users/Joseph Romero IV/OneDrive/Documents/Personal/Projects/music_o_set/temp_export.csv")

# alter data types
temp_table$explicit <- as.logical(temp_table$explicit)
temp_table$release_date_standard <- as.Date(temp_table$release_date_standard, format = '%m/%d/%Y')

# defining correlations
duration <- cor.test(temp_table$popularity, temp_table$duration_ms)
key <- cor.test(temp_table$popularity, temp_table$key)
mode <- cor.test(temp_table$popularity, temp_table$mode)
time_signature <- cor.test(temp_table$popularity, temp_table$time_signature)
acousticness <- cor.test(temp_table$popularity, temp_table$acousticness)
danceability <- cor.test(temp_table$popularity, temp_table$danceability)
energy <- cor.test(temp_table$popularity, temp_table$energy)
instrumentalness <- cor.test(temp_table$popularity, temp_table$instrumentalness)
liveness <- cor.test(temp_table$popularity, temp_table$liveness)
loudness <- cor.test(temp_table$popularity, temp_table$loudness)
speechiness <- cor.test(temp_table$popularity, temp_table$speechiness)
valence <- cor.test(temp_table$popularity, temp_table$valence)
tempo <- cor.test(temp_table$popularity, temp_table$tempo)



# Create dataframe with correlation results
correlation_df <- data.frame(
  variable = c("duration", "key", "mode", "time_signature", "acousticness", "danceability",
               "energy", "instrumentalness", "liveness", "loudness", "speechiness", 
               "valence", "tempo"),
  correlation = c(duration$estimate, key$estimate, mode$estimate, time_signature$estimate,
                  acousticness$estimate, danceability$estimate, energy$estimate,
                  instrumentalness$estimate, liveness$estimate, loudness$estimate,
                  speechiness$estimate, valence$estimate, tempo$estimate),
  p_value = c(duration$p.value, key$p.value, mode$p.value, time_signature$p.value,
              acousticness$p.value, danceability$p.value, energy$p.value,
              instrumentalness$p.value, liveness$p.value, loudness$p.value,
              speechiness$p.value, valence$p.value, tempo$p.value)
)

print(correlation_df[order(correlation_df$correlation, decreasing = TRUE), ])
