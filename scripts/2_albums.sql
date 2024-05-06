DROP TEMPORARY TABLE IF EXISTS artists_albums;

CREATE TEMPORARY TABLE temp_artists_albums AS    
SELECT
	art.name AS artist_name,
	art.main_genre,
    alb.name AS album_name,
    alb.popularity AS album_popularity,
    alb.total_tracks,
    r.release_date,
    apop.year_end_score,
    apop.year
FROM
	releases r
LEFT JOIN
	album_pop apop
    ON r.album_id = apop.album_id
LEFT JOIN
	albums alb
    ON r.album_id = alb.album_id
LEFT JOIN
	artists art
    ON r.artist_id = art.artist_id;


-- Most popular albums in 2018
SELECT
    RANK() OVER(ORDER BY album_popularity DESC, year_end_score DESC) AS album_rank,
    album_name,
    artist_name,
    album_popularity
FROM
	temp_artists_albums
WHERE
	year = '2018'
    AND YEAR(release_date) = '2018'
ORDER BY
	album_popularity DESC
LIMIT
	100;
 
 
-- Most popular albums of the decade
SELECT
	RANK() OVER(ORDER BY SUM(year_end_score) DESC) as rank_album,
    album_name,
    artist_name,
    release_date,
    SUM(year_end_score) AS total_year_end_score
FROM
	temp_artists_albums
WHERE
	release_date BETWEEN '2010' AND '2018'
    AND YEAR(release_date) BETWEEN '2010' AND '2018'
    AND artist_name != 'Various Artists'
GROUP BY
	album_name,
    artist_name,
    release_date
LIMIT
	100;


-- Longest trending albums
SELECT
	MAX(ac.weeks_on_chart) AS weeks_on_chart,
    alb.name AS album_name,
    a.name AS artist_name,
    MIN(ac.week) AS first_week,
    MAX(ac.week) AS last_week
FROM
	album_chart ac
LEFT JOIN
	albums alb
    ON alb.album_id = ac.album_id
LEFT JOIN
	releases r
    ON ac.album_id = r.album_id
LEFT JOIN
	artists a
    ON a.artist_id = r.artist_id
GROUP BY
	album_name,
    artist_name
ORDER BY
	weeks_on_chart DESC
LIMIT
	100;