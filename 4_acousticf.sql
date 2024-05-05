DROP TEMPORARY TABLE IF EXISTS temp;

CREATE TEMPORARY TABLE temp AS
SELECT
    s.song_name,
    s.popularity,
    s.explicit,
    s.song_type,
    t.release_date_standard,
    af.*
FROM
	acoustic_features af
LEFT JOIN
	songs s
    USING(song_id)
LEFT JOIN
	tracks t
    USING(song_id);


-- TEMP
SELECT
	*
FROM
	temp;

-- Amount of songs per year (Probably not include)
SELECT
	YEAR(release_date_standard),
	COUNT(*)
FROM
	temp
GROUP BY
	YEAR(release_date_standard)
ORDER BY
	YEAR(release_date_standard);
    
-- Averages of all the audio features
SELECT
	AVG(popularity),
    AVG(explicit)*100 AS explicit_perc, 
	AVG(duration_ms)/60000 AS duration_mins,
    AVG(acousticness),
    AVG(danceability),
    AVG(energy),
    AVG(instrumentalness),
    AVG(liveness),
    AVG(loudness),
    AVG(speechiness),
    AVG(valence),
    AVG(tempo)
FROM
	temp;

-- averages of the top 10% of popular song (This is limited to recent taste, since popoularity is based of recent plays)
WITH cte AS(
SELECT
	PERCENT_RANK() OVER(ORDER BY popularity DESC) AS pop_percentile,
    song_id
FROM
	Songs
)

SELECT 
    AVG(explicit)*100 AS explicit_perc, 
	AVG(duration_ms)/60000 AS duration_mins,
    AVG(acousticness),
    AVG(danceability),
    AVG(energy),
    AVG(instrumentalness),
    AVG(liveness),
    AVG(loudness),
    AVG(speechiness),
    AVG(valence),
    AVG(tempo)
FROM 
	temp
WHERE 
	song_id IN (
	SELECT song_id
    FROM cte
    WHERE pop_percentile <= .1);

-- Which audio features correlate most with popularity?
SELECT 
    (COUNT(*) * SUM(popularity * danceability) - SUM(popularity) * SUM(danceability)) /
    (SQRT(COUNT(*) * SUM(popularity * popularity) - SUM(popularity) * SUM(popularity)) *
    SQRT(COUNT(*) * SUM(danceability * danceability) - SUM(danceability) * SUM(danceability))) AS correlation_coefficient
FROM 
    temp;

-- Which audio features least correlate with popularity?


-- How has music style changed over time?
-- How popular are older songs today? (limited by recent popoulairity)
SELECT
	YEAR(release_date_standard) AS release_year,
	AVG(popularity),
    AVG(duration_ms)/60000 AS average_duration_mins,
    AVG(acousticness),
    AVG(danceability),
    AVG(energy),
    AVG(instrumentalness),
    AVG(liveness),
    AVG(loudness),
    AVG(speechiness),
    AVG(valence),
    AVG(tempo)
FROM
	temp
GROUP BY
	release_year
ORDER BY
	release_year;