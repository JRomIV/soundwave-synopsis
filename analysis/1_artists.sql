DROP TEMPORARY TABLE IF EXISTS artist_temp;

CREATE TEMPORARY TABLE artist_temp AS
SELECT
    apop.artist_id,
    a.name as artist_name,
    a.main_genre,
    apop.year AS rank_year,
    SUM(apop.year_end_score) AS year_end_score
FROM
    artist_pop apop
LEFT JOIN
	artists a
    ON a.artist_id = apop.artist_id
WHERE
	a.name != 'Various Artists'
GROUP BY
    apop.artist_id,
    a.name,
    apop.year;



    
-- Dashboard export
SELECT
    DENSE_RANK() OVER(PARTITION BY rank_year ORDER BY year_end_score DESC) AS artist_rank,
    artist_name,
    main_genre,
    rank_year,
    year_end_score
FROM
    artist_temp;




-- All time top 50 Billboard artists (using year end score)
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
	artist_rank <= 50;




    
-- Longest trending Billboard artists
SELECT
	ROW_NUMBER() OVER (ORDER BY MAX(ac.weeks_on_chart) DESC) AS artist_rank,
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
	50;

