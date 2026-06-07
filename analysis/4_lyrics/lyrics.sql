-- lyrics export for word analysis 
-- Replacing varoius line breaks with space to ensure a clean export  
SELECT 
    l.song_id, 
    sp.year, 
    g.parent_genre AS genre,
	REPLACE(REPLACE(REPLACE(l.lyrics, '\r', ' '), '\n', ' '), '\t', ' ') AS lyrics
FROM 
    lyrics l
INNER JOIN 
    song_pop sp ON l.song_id = sp.song_id 
INNER JOIN 
    songs s ON l.song_id = s.song_id 
INNER JOIN 
    artists a ON s.artist_id = a.artist_id
LEFT JOIN
	genres g
    ON a.main_genre = g.main_genre
WHERE 
    l.lyrics IS NOT NULL;