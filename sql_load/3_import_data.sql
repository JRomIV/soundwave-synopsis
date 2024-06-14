-- import acoustic features data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/acoustic_features.csv'
INTO TABLE acoustic_features
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- import table for albums
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/albums.csv'
INTO TABLE albums
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- import table for album_chart
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album_chart.csv'
INTO TABLE album_chart
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for album_pop
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album_pop.csv'
INTO TABLE album_pop
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for artists
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artists.csv'
INTO TABLE artists
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for artist_chart
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artist_chart.csv'
INTO TABLE artist_chart
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for artist_pop
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artist_pop.csv'
INTO TABLE artist_pop
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for releases
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/releases.csv'
INTO TABLE releases
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for songs
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/songs.csv'
INTO TABLE songs
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for song_chart
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/song_chart.csv'
INTO TABLE song_chart
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for song_pop
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/song_pop.csv'
INTO TABLE song_pop
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- create table for tracks
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tracks.csv'
INTO TABLE tracks
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;