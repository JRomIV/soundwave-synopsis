-- Most popular genres year over year (year end score)
SELECT 
    sp.year,
    a.main_genre, 
    SUM(sp.year_end_score) AS total_score
FROM 
    song_pop sp
INNER JOIN 
    songs s 
    ON sp.song_id = s.song_id
INNER JOIN 
    artists a 
    ON s.artist_id = a.artist_id
WHERE 
    a.main_genre IS NOT NULL
GROUP BY 
    sp.year, 
    a.main_genre
ORDER BY 
    sp.year,
    total_score DESC;