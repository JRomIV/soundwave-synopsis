DROP TEMPORARY TABLE IF EXISTS temp_names;

CREATE TEMPORARY TABLE temp_names AS
SELECT
	t.*,
    alb.name AS album_name,
    r.artist_id,
    a.name AS artist_name
FROM
	tracks t
LEFT JOIN
	albums alb
	ON t.album_id = alb.album_id
LEFT JOIN
	releases r
    ON r.album_id = t.album_id
LEFT JOIN
	artists a
    ON a.artist_id = r.artist_id;


-- Most popular songs in 2018
SELECT
	ROW_NUMBER() OVER(ORDER BY s.popularity DESC) AS song_rank,
	s.song_name,
    tn.artist_name,
    s.explicit
FROM
	songs s
LEFT JOIN
	temp_names tn
    ON s.song_id = tn.song_id
LEFT JOIN
	song_pop sp
    ON s.song_id = sp.song_id
WHERE
	sp.year = '2018'
	AND YEAR(tn.release_date_standard) = '2018'
LIMIT
	100;


-- Most popular songs of the decade
SELECT
	RANK() OVER(ORDER BY SUM(sp.year_end_score) DESC) AS song_rank,
	s.song_name,
    tn.artist_name,
    SUM(sp.year_end_score) AS year_end_score,
    tn.release_date
FROM
	song_pop sp
LEFT JOIN
	Songs s
    ON sp.song_id = s.song_id
LEFT JOIN
	temp_names tn
    ON tn.song_id = sp.song_id
WHERE
	sp.year BETWEEN '2010' AND '2018'
    AND YEAR(tn.release_date) BETWEEN '2010' AND '2018'
GROUP BY
	s.song_name,
    tn.artist_name,
    tn.release_date
LIMIT
	100;

-- Longest trending songs
SELECT
	MAX(sc.weeks_on_chart) AS weeks_on_chart,
    s.song_name,
    tn.artist_name,
    MIN(week) AS first_week,
    MAX(week) AS last_week
FROM
	song_chart sc
LEFT JOIN
	songs s
    ON s.song_id = sc.song_id
LEFT JOIN
	temp_names tn
    ON tn.song_id = sc.song_id
GROUP BY
	s.song_name,
    tn.artist_name
ORDER BY
	weeks_on_chart DESC
LIMIT
	100;