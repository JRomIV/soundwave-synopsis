-- All songs and their acoustic features
WITH distinct_song_pop AS (
    SELECT DISTINCT song_id
    FROM song_pop
)
SELECT 
    s.song_id,
    s.explicit,
    CASE 
        WHEN s.song_type = 'collaboration' THEN 1 
        WHEN s.song_type = 'Solo' THEN 0 
    END AS is_collaboration,
    af.key, af.mode, af.time_signature, 
    af.acousticness, af.danceability, af.energy, af.instrumentalness, 
    af.liveness, af.loudness, af.speechiness, af.valence, af.tempo,
    CASE 
        WHEN dsp.song_id IS NOT NULL THEN 1 ELSE 0 
    END AS is_billboard
FROM 
    songs s
LEFT JOIN 
    acoustic_features af 
    ON s.song_id = af.song_id
LEFT JOIN 
    distinct_song_pop dsp 
    ON s.song_id = dsp.song_id;