-- Billboard vs non-hits year over year
SELECT 
    YEAR(t.release_date_standard) AS year,
    s.is_billboard,
    AVG(ac.danceability) AS avg_danceability,
    AVG(ac.energy) AS avg_energy,
    AVG(ac.valence) AS avg_valence,
    AVG(ac.tempo) AS avg_tempo,
    AVG(ac.speechiness) AS avg_speechiness,
    AVG(ac.acousticness) AS avg_acousticness,
    AVG(ac.loudness) AS avg_loudness,
    AVG(ac.duration_ms) / 60000 AS avg_duration_min,
    AVG(s.explicit) * 100 AS explicit_percentage,
    COUNT(s.song_id) AS total_songs
FROM 
	songs s
INNER JOIN 
	tracks t ON s.song_id = t.song_id
INNER JOIN 
	acoustic_features ac ON s.song_id = ac.song_id
WHERE 
	YEAR(t.release_date_standard) >= 1964
GROUP BY 
	YEAR(t.release_date_standard), is_billboard
ORDER BY 
	year ASC, is_billboard DESC;
