-- lyrics export for tableau visualization 

SELECT 
    l.song_id, 
    sp.year, 
    a.main_genre AS genre, 
    l.lyrics
FROM 
    lyrics l
INNER JOIN 
    song_pop sp ON l.song_id = sp.song_id 
INNER JOIN 
    songs s ON l.song_id = s.song_id 
INNER JOIN 
    artists a ON s.artist_id = a.artist_id 
WHERE 
    l.lyrics IS NOT NULL;



