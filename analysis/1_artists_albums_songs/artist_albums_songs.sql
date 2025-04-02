-- All time top 25 Billboard artists (using year end score)
WITH cte AS (
SELECT
    DENSE_RANK() OVER(ORDER BY SUM(apop.year_end_score) DESC) AS artist_rank,
    a.artist_id,
    a.artist_name,
    a.main_genre,
    SUM(apop.year_end_score) AS total_year_end_score
FROM
    artist_pop apop
INNER JOIN
	artists a
    ON apop.artist_id = a.artist_id
WHERE
	a.artist_name != 'Various Artists' 
GROUP BY
	a.artist_id,
    a.artist_name,
    a.main_genre
)
SELECT
	*
FROM
	cte
WHERE
	artist_rank <= 25;



-- Export for artists
(SELECT 'artist_id', 'artist_name', 'followers', 'popularity', 'artist_type', 'genres', 'main_genre')
UNION ALL
(SELECT 
    artist_id, 
    artist_name,  
    followers, 
    popularity, 
    artist_type, 
    genres, 
    main_genre
 FROM artists)
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artists_exported.tsv'
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- All time top 25 Billboard albums (using year end score)
WITH cte AS (
    SELECT
        DENSE_RANK() OVER(ORDER BY SUM(apop.year_end_score) DESC) AS album_rank,
        alb.album_id,
        alb.album_name,
        a.artist_name,
        a.main_genre,
        SUM(apop.year_end_score) AS total_year_end_score
    FROM
        album_pop apop
    INNER JOIN 
		albums alb 
        ON apop.album_id = alb.album_id
    LEFT JOIN 
		artists a 
        ON alb.artist_id = a.artist_id
    GROUP BY 
		alb.album_id, alb.album_name, a.artist_name, a.main_genre
)
SELECT 
	* 
FROM 
	cte
WHERE 
	album_rank <= 25;

-- All time top 25 Billboard songs (using year end score)
WITH cte AS (
    SELECT
        DENSE_RANK() OVER(ORDER BY SUM(spop.year_end_score) DESC) AS song_rank,
        s.song_id,
        s.song_name,
        a.artist_name,
        a.main_genre,
        SUM(spop.year_end_score) AS total_year_end_score
    FROM
        song_pop spop
    INNER JOIN 
		songs s 
        ON s.song_id = spop.song_id
    LEFT JOIN 
		artists a 
        ON a.artist_id = s.artist_id 
    GROUP BY 
		s.song_id, s.song_name, a.artist_id, a.artist_name, a.main_genre
)
SELECT 
	* 
FROM 
	cte
WHERE 
	song_rank <= 25;