DROP TEMPORARY TABLE IF EXISTS attributes;

CREATE TEMPORARY TABLE attributes AS
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


-- Amount of songs per year (Probably not include)
SELECT
	YEAR(release_date_standard),
	COUNT(*)
FROM
	attributes
GROUP BY
	YEAR(release_date_standard)
ORDER BY
	YEAR(release_date_standard);

    
-- Avg of all the audio features
SELECT
	AVG(popularity),
    AVG(explicit)*100 AS explicit_perc, 
	AVG(duration_ms)/60000 AS avg_duration_mins,
    AVG(acousticness) AS avg_acousticness,
    AVG(danceability) AS avg_danceability,
    AVG(energy) AS avg_energy,
    AVG(instrumentalness) AS avg_instrumentalness,
    AVG(liveness) AS avg_liveness,
    AVG(loudness) AS avg_loudness,
    AVG(speechiness) AS avg_speechiness,
    AVG(valence) AS avg_valence,
    AVG(tempo) AS avg_tempo
FROM
	attributes;

-- Avg of the top 10% of current (2018) popular songs 
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
    AVG(acousticness) AS avg_acousticness,
    AVG(danceability) AS avg_danceability,
    AVG(energy) AS avg_energy,
    AVG(instrumentalness) AS avg_instrumentalness,
    AVG(liveness) AS avg_liveness,
    AVG(loudness) AS avg_loudness,
    AVG(speechiness) AS avg_speechiness,
    AVG(valence) AS avg_valence,
    AVG(tempo) AS avg_tempo
FROM 
	attributes
WHERE 
	song_id IN (
	SELECT song_id
    FROM cte
    WHERE pop_percentile <= .1);

-- Musical attributes across the years 
-- (popularity limited to recent plays)
SELECT
	YEAR(release_date_standard) AS release_year,
	AVG(popularity) AS avg_popularity,
    AVG(duration_ms)/60000 AS average_duration_mins,
    AVG(acousticness) AS avg_acousticness,
    AVG(danceability) AS avg_danceability,
    AVG(energy) AS avg_energy,
    AVG(instrumentalness) AS avg_instrumentalness,
    AVG(liveness) AS avg_liveness,
    AVG(loudness) AS avg_loudness,
    AVG(speechiness) AS avg_speechiness,
    AVG(valence) AS avg_valence,
    AVG(tempo) AS avg_tempo
FROM
	attributes
GROUP BY
	release_year
ORDER BY
	release_year;