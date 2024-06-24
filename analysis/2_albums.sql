DROP TEMPORARY TABLE IF EXISTS temp_albums;

CREATE TEMPORARY TABLE temp_albums AS
SELECT
	apop.album_id,
    alb.name AS album_name,
    a.name artist_name,
    a.main_genre,
    apop.year AS rank_year,
    r.release_date AS release_date,
    SUM(apop.year_end_score) AS year_end_score
FROM
    album_pop apop
LEFT JOIN
	albums alb
    ON alb.album_id = apop.album_id
LEFT JOIN
	releases r
    ON r.album_id = apop.album_id
LEFT JOIN
	artists a
    ON a.artist_id = r.artist_id
GROUP BY
	apop.album_id,
    alb.name,
    artist_name,
    a.main_genre,
    apop.year,
    r.release_date;




-- Dashboard export
SELECT
	DENSE_RANK() OVER(PARTITION BY rank_year ORDER BY year_end_score DESC) AS album_rank,
    album_name,
    artist_name,
    main_genre,
    rank_year,
    YEAR(release_date) AS release_date,
    year_end_score
FROM
	temp_albums;




-- All time top 50 Billboard albums
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

SELECT
	*
FROM
	cte
WHERE
	album_rank <= 50;



-- Longest trending Billboard albums
SELECT
	ROW_NUMBER() OVER (ORDER BY MAX(ac.weeks_on_chart) DESC) AS album_rank,
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
	50;