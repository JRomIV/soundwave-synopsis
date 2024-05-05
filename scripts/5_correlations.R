# import data
temp_attributes <- read.csv("temp_attributes.csv")

# defining correlations
duration <- cor.test(temp_attributes$popularity, temp_attributes$duration_ms)
key <- cor.test(temp_attributes$popularity, temp_attributes$key)
mode <- cor.test(temp_attributes$popularity, temp_attributes$mode)
time_signature <- cor.test(temp_attributes$popularity, temp_attributes$time_signature)
acousticness <- cor.test(temp_attributes$popularity, temp_attributes$acousticness)
danceability <- cor.test(temp_attributes$popularity, temp_attributes$danceability)
energy <- cor.test(temp_attributes$popularity, temp_attributes$energy)
instrumentalness <- cor.test(temp_attributes$popularity, temp_attributes$instrumentalness)
liveness <- cor.test(temp_attributes$popularity, temp_attributes$liveness)
loudness <- cor.test(temp_attributes$popularity, temp_attributes$loudness)
speechiness <- cor.test(temp_attributes$popularity, temp_attributes$speechiness)
valence <- cor.test(temp_attributes$popularity, temp_attributes$valence)
tempo <- cor.test(temp_attributes$popularity, temp_attributes$tempo)



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
