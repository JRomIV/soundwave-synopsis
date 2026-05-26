-- Tableau passthrough exports
-- Create Tableau popularity exports with standardized genre fields.
-- Data without a usable main_genre are excluded so dashboard filters remain consistent.

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


-- Dim Year
-- Creates a shared year dimension for dashboard level filtering.
-- Limited to the popularity exports because these are the base tables
SELECT DISTINCT year
FROM artist_pop
WHERE year IS NOT NULL
UNION
SELECT DISTINCT year
FROM album_pop
WHERE year IS NOT NULL
UNION
SELECT DISTINCT year
FROM song_pop
WHERE year IS NOT NULL
ORDER BY year;


-- Dim Genre
-- for Tableau dashboard level filtering.
SELECT DISTINCT
	parent_genre
FROM
	genres
WHERE
	parent_genre IS NOT NULL
    AND parent_genre <> '-'
ORDER BY
	parent_genre;
    

-- Acoustic features export
SELECT
	*
FROM
	acoustic_features;


-- Albums export
SELECT
	*
FROM
	albums;


-- Artists export
SELECT
	*
FROM
	artists;

-- Songs export
SELECT
	*
FROM
	songs;


-- Billboard vs non-hits year over year (avg_af_allsongs)
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
	tracks t ON s.song_id = t.song_id
INNER JOIN 
	acoustic_features ac ON s.song_id = ac.song_id
WHERE 
	YEAR(t.release_date_standard) >= 1964
GROUP BY 
	YEAR(t.release_date_standard), is_billboard
ORDER BY 
	year ASC, is_billboard DESC;

