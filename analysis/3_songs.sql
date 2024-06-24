DROP TEMPORARY TABLE IF EXISTS temp_songs;

CREATE TEMPORARY TABLE temp_songs AS
SELECT
	sp.song_id,
    s.song_name,
    s.artist_extracted AS artist_name,
    a.main_genre,
    sp.year AS rank_year,
    r.release_date AS release_date,
    SUM(sp.year_end_score) AS year_end_score
FROM
    song_pop sp
LEFT JOIN
	songs s
    ON s.song_id = sp.song_id
LEFT JOIN
	tracks t
	ON sp.song_id = t.song_id
LEFT JOIN
	releases r
	ON r.album_id = t.album_id
LEFT JOIN
	artists a
    ON a.artist_id = r.artist_id
GROUP BY
	sp.song_id,
    s.song_name,
    s.artist_extracted,
    a.main_genre,
    sp.year,
    r.release_date;




-- Dashboard export
SELECT
	DENSE_RANK() OVER(PARTITION BY rank_year ORDER BY year_end_score DESC) AS song_rank,
    song_name,
    artist_name,
    main_genre,
    rank_year,
    YEAR(release_date) AS release_date,
    year_end_score
FROM
	temp_songs;




-- All time top 50 Billboard songs  
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
	song_rank <= 50;



 
-- Longest trending Billboard songs
SELECT
	ROW_NUMBER() OVER (ORDER BY MAX(sc.weeks_on_chart) DESC) AS album_rank,
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
	50;