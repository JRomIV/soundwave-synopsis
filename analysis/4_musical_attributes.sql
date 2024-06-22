DROP TEMPORARY TABLE IF EXISTS temp_attributes;

CREATE TEMPORARY TABLE temp_attributes AS
SELECT
    s.song_name,
    s.popularity,
    s.explicit,
    s.song_type,
    t.release_date_standard,
    af.*,
    af.duration_ms/60000 AS duration_min
FROM
	acoustic_features af
LEFT JOIN
	songs s
    USING(song_id)
LEFT JOIN
	tracks t
    USING(song_id);


-- Acoustic features for export
SELECT
	*
FROM
	temp_attributes;
    

-- Avg of all the audio features
SELECT
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
	temp_attributes;



-- Avg attributes of the songs in the top 10% of popularity
WITH cte AS(
SELECT
	PERCENT_RANK() OVER(ORDER BY popularity DESC) AS pop_percentile,
    song_id
FROM
	Songs
)

SELECT 
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
	temp_attributes
WHERE 
	song_id IN (
	SELECT song_id
    FROM cte
    WHERE pop_percentile <= .1);


    
-- Acoustic Features of the top 100 songs from 1964-2019 (For average calculation)
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
