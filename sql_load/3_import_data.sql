USE musicoset;
SET NAMES 'utf8mb4';

-- import data into acoustic features table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/acoustic_features.csv'
INTO TABLE acoustic_features
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_id, duration_ms, `key`, `mode`, time_signature, 
 acousticness, danceability, energy, instrumentalness, 
 liveness, loudness, speechiness, valence, tempo);
 

-- import data into albums table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/albums.csv'
INTO TABLE albums
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(album_id, album_name, @billboard, @artists, popularity, total_tracks, album_type, @image_url)
SET
  artist_id = TRIM(TRAILING "'" FROM SUBSTRING_INDEX(SUBSTRING_INDEX(@artists, ":", 1), "{'", -1));


-- import data into album_chart table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album_chart.csv'
INTO TABLE album_chart
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(album_id, rank_score, peak_position, @week_count, @date)
SET
  weeks_on_chart = NULLIF(TRIM(@week_count),''),
  `week` = STR_TO_DATE(TRIM(@date), '%Y-%m-%d');


-- import data into album_pop table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album_pop.csv'
INTO TABLE album_pop
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(album_id, year_end_score, @is_pop, `year`)
SET
  is_pop = CASE
              WHEN LOWER(TRIM(@is_pop)) IN ('true','1','yes') THEN 1
              WHEN LOWER(TRIM(@is_pop)) IN ('false','0','no') THEN 0
              ELSE NULL
           END;
           

-- import data into artists table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artists.csv'
INTO TABLE artists
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(artist_id, artist_name, @followers, popularity, artist_type, main_genre, genres, @image_url)
SET
  followers = NULLIF(TRIM(REPLACE(LOWER(@followers), 'none', '')),'');


-- import data into artist_chart table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artist_chart.csv'
INTO TABLE artist_chart
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(artist_id, rank_score, peak_position, weeks_on_chart, `week`);


-- import data into artist_pop table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artist_pop.csv'
INTO TABLE artist_pop
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(artist_id, year_end_score, @is_pop, `year`)
SET
  is_pop = CASE
              WHEN LOWER(TRIM(@is_pop)) IN ('true','1','yes') THEN 1
              WHEN LOWER(TRIM(@is_pop)) IN ('false','0','no') THEN 0
              ELSE NULL
           END;


-- import data into releases table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/releases.csv'
INTO TABLE releases
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(artist_id, album_id, release_date, release_date_precision);


-- import data into songs table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/songs.csv'
INTO TABLE songs
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(song_id, song_name, billboard, @artists, popularity, @explicit, song_type)
SET
  artist_id = TRIM(TRAILING "'" FROM SUBSTRING_INDEX(SUBSTRING_INDEX(@artists, ":", 1), "{'", -1)),
  artist_extracted = TRIM(BOTH "'" FROM SUBSTRING_INDEX(SUBSTRING_INDEX(@artists, "': '", -1), "'}", 1)),
  explicit = CASE
               WHEN LOWER(TRIM(@explicit)) IN ('true','1','yes') THEN 1
               WHEN LOWER(TRIM(@explicit)) IN ('false','0','no') THEN 0
               ELSE NULL
             END,
  is_billboard = 1;


-- import data into song_chart table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/song_chart.csv'
INTO TABLE song_chart
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_id, rank_score, peak_position, weeks_on_chart, `week`);


-- import data into song_pop table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/song_pop.csv'
INTO TABLE song_pop
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_id, year_end_score, @is_pop, `year`)
SET
  is_pop = CASE
              WHEN LOWER(TRIM(@is_pop)) IN ('true','1','yes') THEN 1
              WHEN LOWER(TRIM(@is_pop)) IN ('false','0','no') THEN 0
              ELSE NULL
           END;


-- import data into tracks table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tracks.csv'
INTO TABLE tracks
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_id, album_id, track_number, release_date, release_date_precision)
SET
  release_date_standard = CASE
                             WHEN release_date_precision = 'day' THEN STR_TO_DATE(release_date, '%Y-%m-%d')
                             WHEN release_date_precision = 'month' THEN STR_TO_DATE(CONCAT(release_date, '-01'), '%Y-%m-%d')
                             WHEN release_date_precision = 'year' THEN STR_TO_DATE(CONCAT(release_date, '-01-01'), '%Y-%m-%d')
                             ELSE NULL
                          END;


-- import data into lyrics table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lyrics.csv'
INTO TABLE lyrics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(song_id, lyrics);


-- importing data into the genres table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/genres.csv'
INTO TABLE genres
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(main_genre, parent_genre);


-- importing additional (non-hit) songs into the songs table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/songs_nonhits.csv'
INTO TABLE songs
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_id, song_name, billboard, @artists, popularity, @explicit, song_type, artist_extracted)
SET
  explicit = CASE
               WHEN LOWER(TRIM(@explicit)) IN ('true','1','yes') THEN 1
               WHEN LOWER(TRIM(@explicit)) IN ('false','0','no') THEN 0
               ELSE NULL
             END,
  is_billboard = 0,
  artist_id = TRIM(TRAILING "'" FROM SUBSTRING_INDEX(SUBSTRING_INDEX(@artists, ":", 1), "{'", -1));


-- import additional data (non-hits) into the acoustic features table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/af_nonhits.csv'
IGNORE
INTO TABLE acoustic_features
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_id, duration_ms, `key`, `mode`, time_signature,
 acousticness, danceability, energy, instrumentalness,
 liveness, loudness, speechiness, valence, tempo);


-- import additional data (non-hits) into the tracks table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tracks_nonhits.csv'
INTO TABLE tracks
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(song_id, album_id, track_number, release_date, release_date_precision, release_date_standard);