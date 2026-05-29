-- Tableau export queries
-- These queries create Tableau CSV exports
-- Popularity exports are combined with names and parent genres

-- Updated artist pop
SELECT
	ap.*,
    art.artist_name,
    g.parent_genre
FROM
	artist_pop ap
INNER JOIN
	artists art
	ON ap.artist_id = art.artist_id
INNER JOIN
	genres g
    ON art.main_genre = g.main_genre
WHERE
	g.parent_genre IS NOT NULL;


-- Updated album pop
SELECT
	ap.*,
    a.artist_id,
    a.album_name,
    art.artist_name,
    g.parent_genre
FROM
	album_pop ap
INNER JOIN
	albums a
    ON ap.album_id = a.album_id
INNER JOIN
	artists art
    ON art.artist_id = a.artist_id
INNER JOIN
	genres g
    ON art.main_genre = g.main_genre
WHERE
	g.parent_genre IS NOT NULL;


-- Updated song pop
SELECT
	sp.*,
    s.artist_id,
    s.song_name,
    art.artist_name,
    g.parent_genre
FROM
	song_pop sp
INNER JOIN
	songs s
	ON sp.song_id = s.song_id
INNER JOIN
	artists art
    ON s.artist_id = art.artist_id
INNER JOIN
	genres g
    ON art.main_genre = g.main_genre
WHERE
	g.parent_genre IS NOT NULL;


-- Acoustic features export
SELECT
	af.*
FROM
	acoustic_features af
INNER JOIN
	songs s
    ON af.song_id = s.song_id
    AND s.is_billboard = 1;


-- Billboard vs non-hits year over year
SELECT 
    YEAR(t.release_date_standard) AS year,
    s.is_billboard,
    AVG(ac.danceability) AS avg_danceability,
    AVG(ac.energy) AS avg_energy,
    AVG(ac.valence) AS avg_valence,
    AVG(ac.tempo) AS avg_tempo,
    AVG(ac.speechiness) AS avg_speechiness,
    AVG(ac.acousticness) AS avg_acousticness,
    AVG(ac.loudness) AS avg_loudness,
    AVG(ac.duration_ms) / 60000 AS avg_duration_min,
    AVG(s.explicit) * 100 AS explicit_percentage,
    COUNT(s.song_id) AS total_songs
FROM 
	songs s
INNER JOIN 
	tracks t
    ON s.song_id = t.song_id
INNER JOIN 
	acoustic_features ac
    ON s.song_id = ac.song_id
WHERE 
	YEAR(t.release_date_standard) >= 1964
GROUP BY 
	YEAR(t.release_date_standard),
    s.is_billboard
ORDER BY 
	year ASC,
    s.is_billboard DESC;