import pandas as pd
import re

# Load data
df = pd.read_csv("sql_lyrics.tsv", sep="\t", encoding="utf-8", quoting=3)


# Define stopwords and ensure lowercase
stop_words = {
    "i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours",
    "yourself", "yourselves", "he", "him", "his", "himself", "she", "her", "hers",
    "herself", "it", "its", "itself", "they", "them", "their", "theirs", "themselves",
    "what", "which", "who", "whom", "this", "that", "these", "those", "am", "is", "are",
    "was", "were", "be", "been", "being", "have", "has", "had", "having", "do", "does",
    "did", "doing", "a", "an", "the", "and", "but", "if", "or", "because", "as", "until",
    "while", "of", "at", "by", "for", "with", "about", "against", "between", "into",
    "through", "during", "before", "after", "above", "below", "to", "from", "up", "down",
    "in", "out", "on", "off", "over", "under", "again", "further", "then", "once", "here",
    "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", "more",
    "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so",
    "than", "too", "very", "can", "will", "just", "don", "should", "now", "yeah", "ooh",
    "oh", "uh", "la", "na", "woah", "hey", "yeah", "ah", "baby", "cause", "gonna",
    "2018", "2017", "chorus", "verse", "like", "xa0", "xa0xa0xa0xa0xa0xa0xa0xa0 "
}

stop_words = {word.lower() for word in stop_words}

# Clean and tokenize lyrics
df["lyrics"] = df["lyrics"].fillna("").str.lower().str.replace(r'\W+', ' ', regex=True)
df["tokens"] = df["lyrics"].str.split()
df["tokens"] = df["tokens"].apply(lambda words: [word for word in words if word not in stop_words and len(word) > 2])

# Explode dataset \n
df_exploded = df.explode("tokens")[["year", "genre", "tokens"]].rename(columns={"tokens": "word"})

# Count occurrences 
df_word_counts = df_exploded.value_counts(["year", "genre", "word"]).reset_index(name="count")

# Get top 25 words per (year, genre)
df_top_25 = df_word_counts.groupby(["year", "genre"], group_keys=True)[["word", "count"]] \
    .apply(lambda x: x.nlargest(25, "count")) \
    .reset_index()

# Remove extra column if it appears
df_top_25 = df_top_25.drop(columns=["level_2"], errors="ignore")

# Save to CSV
df_top_25.to_csv("word_count.csv", index=False)
