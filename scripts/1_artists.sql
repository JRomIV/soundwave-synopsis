-- Most popular artists of 2018
SELECT
	RANK() OVER(ORDER BY a.popularity DESC, apop.year_end_score DESC) as artist_rank,
    a.name,
    a.main_genre,
    a.popularity
FROM
	artists a
LEFT JOIN
	artist_pop apop
    USING(artist_id)
WHERE
	apop.year = '2018'
    AND a.name != 'Various Artists'
LIMIT
	100;
    
-- Most popular artists of the decade
SELECT
    RANK() OVER(ORDER BY SUM(apop.year_end_score) DESC) AS artist_rank,
    a.name,
    a.main_genre,
    SUM(apop.year_end_score) AS total_year_end_score
FROM
    artists a
LEFT JOIN
    artist_pop apop
    ON a.artist_id = apop.artist_id 
WHERE
    apop.year BETWEEN '2010' AND '2018'
    AND a.name != 'Various Artists'
GROUP BY
    a.name,
    a.main_genre  -- Only group by name and genre
LIMIT
    100;


    
-- Longest trending artists     
SELECT
	MAX(ac.weeks_on_chart) AS weeks_on_chart,
	a.name,
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