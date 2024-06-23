# Introduction
This analysis explores popular music thoughout the decades using a database contaning popular Billboard music and musical elements charted by Spotify. We dive into the most popular Artists, Albums, and Songs spanning from 1964 to 2018 while discovering any correlations we may find along the way. Provided below are vizualiztions and a Tableau Dashboard to follow along if so desired.


# Background
Music is an undeniable part of the human experience that not only enriches culture but is an expression of it. Naturally I am very interested in the topic and was excited when I came across this database that not only contained a large amount of music but the musical elements of each song. As a brief overview I will explore the most popular music across time and what attributes that may be associated with popularity. I will also explore if music has changed overtime and if we see fundemental differences between the very top songs and the rest of the charts. Specifically, this analysis will answer the following questions:
1. Who are the most prominent artists of all time?
2. Which albums are the most popular of all time?
3. What are the most popular songs of all time?
4. Have musical attributes changed across time?
5. Are there any musical elements that correlate with each other?


# Tools
### Dashboard
[Link to Tableau Public]
[Image of Dashboard]

### Technology Stack
I used a variety of tools to explore and gain experience with different methods:
- **Git/GitHub**: For version control and to share my insights
- **MySQL Workbench**: For database management and queries
- **Python/R**: To create a small script to calculate correlations
- **Tableau**: For all the data visualization
- **Visual Studio Code**: For file management and running Python/R scripts


# Analysis
In order to identify the most popular music I used a summation of **Year End Score** instead of **Popularity** which is based on recent plays and therefore recent popularity. **Year End Score** is a calculation derived from the combination of peak chart position and the amount of weeks it has been on the chart and was used as the primary metric for popularity in this analysis. For further clarification about the definitions used please reference the metadata file.


### 1. Who are the most prominent artists of all time?
#### A. Artists with highest Year End Score

This query provides a list of top 100 ranked Billboard Artists of all time.
``` sql
WITH cte AS (
SELECT
    DENSE_RANK() OVER(ORDER BY SUM(year_end_score) DESC) AS artist_rank,
    artist_name,
    main_genre,
    SUM(year_end_score) AS total_year_end_score
FROM
    artist_temp
GROUP BY
	artist_name,
    main_genre
)

SELECT
	*
FROM
	cte
WHERE
	artist_rank <= 100;
```
Here is a list of the most popular Billboard artists of all time. Its notable that 50% of the 20 most popular artists of all time belong to the Rock genre. Country also has strong presence within the top 100 of all time.


[Artists Chart]

- b. Who where the longest trending artists?
``` sql
SELECT
	a.name,
    a.main_genre,
	MAX(ac.weeks_on_chart) AS weeks_on_chart,
    MIN(ac.week) AS first_week,
    MAX(ac.week) AS last_week
FROM
	artist_chart ac
LEFT JOIN
	artists a
    ON ac.artist_id = a.artist_id
WHERE
	a.name IS NOT NULL
    AND a.name != 'Various Artists'
GROUP BY
	a.name,
    a.main_genre
ORDER BY
	weeks_on_chart DESC
LIMIT
	100;
```
With no surprise The Beatles top the chart starting their regin in 1964 to basically the most current data available within the data. Eminem is a close 2nd and starting his appearence in 1999, this is an indication that althought the Beatles first appeared in 1964 it has not been consistant.

2. Most popular albums of all time
- a. Which albums scored the highest?
```sql
WITH cte AS(
SELECT
	DENSE_RANK() OVER(ORDER BY SUM(year_end_score) DESC) AS album_rank,
    album_name,
    artist_name,
    main_genre,
    MIN(YEAR(release_date)) AS release_date,
    SUM(year_end_score) AS total_year_end_score
FROM
	temp_albums
GROUP BY
    album_name,
    artist_name,
    main_genre
)

[Albums Chart]
Explination here

SELECT
	*
FROM
	cte
WHERE
	album_rank <= 100;
```
By far "The Dark Side of the Moon" by Pink Floyd is the highest ranked album of all time. With over double the score of the #2 album (Journey's Greatest Hits) it creates a statement of how much of a massive success this album is. Within the top 10 we see Rock dominating with 60% of the share. The Beatles once again show 6 times within the top 100 followed by Micheal Jackson with 4 times and Taylor Swift at 3.

- b. What were the longest trending albums?
```sql
SELECT
	ta.album_name AS album_name,
    ta.artist_name AS artist_name,
	MAX(ac.weeks_on_chart) AS weeks_on_chart,
    MIN(ac.week) AS first_week,
    MAX(ac.week) AS last_week
FROM
	album_chart ac
LEFT JOIN
	temp_albums ta
    ON ac.album_id = ta.album_id
GROUP BY
	album_name,
    artist_name
ORDER BY
	weeks_on_chart DESC
LIMIT
	100;
```
Darkside of the Moon again almost doubles the #2 album when it comes to trending length. The 940 weeks is equal to about 18 years of the album trending straight over the span of 45 years. We also see "Greatest Hits" for various artists appear 6 times within the longest trending albums. The Beatles appear 6 times followed by Michael Jackson 5 with a comibined total of 1405 and 1188 weeks respectively. 

3. Most popular Songs of all time
a. Which songs scored the highest?
```sql
WITH cte AS(
SELECT
	DENSE_RANK() OVER(ORDER BY SUM(year_end_score) DESC) AS song_rank,
    song_name,
    artist_name,
    main_genre,
    MIN(YEAR(release_date)) AS release_date,
    SUM(year_end_score) AS total_year_end_score
FROM
	temp_songs
GROUP BY
    song_name,
    artist_name,
    main_genre
)
    
SELECT
	*
FROM
	cte
WHERE
	song_rank <= 100;
```
[Song Chart]
Most popular song by Rank is Radioactive by Imagine Dragons be the only song to break 5 digits. This chart appears to be dominated by Pop.

b. Longest trending songs
```sql
SELECT
    ts.song_name,
    ts.artist_name,
	MAX(sc.weeks_on_chart) AS weeks_on_chart,
    MIN(week) AS first_week,
    MAX(week) AS last_week
FROM
	song_chart sc
LEFT JOIN
	temp_songs ts
    ON ts.song_id = sc.song_id
GROUP BY
    ts.song_name,
    ts.artist_name
ORDER BY
	weeks_on_chart DESC
LIMIT
	100;
```
Song chart appears to be dominated by Pop. A lot of these songs are more recent.

4. What are the correlations?
```r
library(dplyr)

# import data
temp_attributes <- read.csv("temp_attributes.csv")

# create a correlation matrix
numeric_attributes <- select(temp_attributes, -song_name, -song_type, -release_date_standard, -song_id)
correlations <- cor(numeric_attributes, use = "everything", method = "pearson")

# export csv
write.csv(correlations,"correlations.csv")
```

```python
import pandas as pd

# import data
temp_attributes = pd.read_csv('temp_attributes.csv')

# create a correlation matrix
numeric_attributes = temp_attributes.drop(columns = ['song_name', 'song_type', 'release_date_standard', 'song_id'])
correlations = numeric_attributes.corr(method = 'pearson')

# export csv
correlations.to_csv('correlations.csv')
```

[Correlation Matrix]

Correlations weren't the strongest although there are some notable mentions Loundness~Energy having the clearest positive correlation out of the whole dateset. We also see a strong negative correlation with Energy~Acousticness indicating acousticness associated with less energy. 

6. Musical Attributes over time
```sql
WITH cte AS(
SELECT
    RANK() OVER(PARTITION BY YEAR(t.release_date_standard) ORDER BY SUM(sp.year_end_score) DESC) AS song_rank,
    sp.song_id AS id,
    YEAR(t.release_date_standard) AS release_date_standard,
    s.explicit,
    SUM(sp.year_end_score) AS total_year_end_score
FROM
    song_pop sp
LEFT JOIN
	tracks t
    ON t.song_id = sp.song_id
LEFT JOIN
	songs s
    ON sp.song_id = s.song_id
GROUP BY
    sp.song_id,
    YEAR(t.release_date_standard),
	s.explicit
)
SELECT
	song_rank,
    release_date_standard,
    explicit,
    ac.*,
    ac.duration_ms/60000 AS duration_min
FROM
	cte
LEFT JOIN
	acoustic_features ac
    ON ac.song_id = cte.id
WHERE
	song_rank <= 100
    AND release_date_standard >= 1964;
```
[Acoustic Image]

The above chart spans how these different attributes have changes over time. This also compares the difference betweent the top 100 billboard songs and the rest of Billboard songs that made the chart. 

# Conclusions
## Insights
Amount to how many bulllets on top
1. A
2. 
3.
4.
5.

## Closing Thoughts
