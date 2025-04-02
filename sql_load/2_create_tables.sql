-- create table for acoustic_features
CREATE TABLE acoustic_features 
(
  song_id VARCHAR(22) PRIMARY KEY,
  duration_ms INT,
  `key` INT,
  mode INT,
  time_signature INT,
  acousticness DECIMAL(11,6),
  danceability DECIMAL(4,3),
  energy DECIMAL(6,5),
  instrumentalness DECIMAL(12,7),
  liveness DECIMAL(5,4),
  loudness DECIMAL(6,3),
  speechiness DECIMAL(6,4),
  valence DECIMAL(5,4),
  tempo DECIMAL(6,3)
); 


-- create table for albums
CREATE TABLE albums 
(
  album_id VARCHAR(22) PRIMARY KEY,
  name VARCHAR(292),
  billboard VARCHAR(75),
  artists VARCHAR(2228),
  popularity INT,
  total_tracks INT,
  album_type VARCHAR(11),
  image_url VARCHAR(64)
);


-- create table for album_chart
CREATE TABLE album_chart 
(
  album_id VARCHAR(22) PRIMARY KEY,
  rank_score INT,
  peak_position INT,
  weeks_on_chart INT,
  week DATE
);


-- create table for album_pop
CREATE TABLE album_pop 
(
  album_id VARCHAR(22) PRIMARY KEY,
  year_end_score INT,
  is_pop VARCHAR(5),
  year INT
);


-- create table for artists
CREATE TABLE artists 
(
  artist_id VARCHAR(22) PRIMARY KEY,
  name VARCHAR(91),
  followers INT,
  popularity INT,
  artist_type VARCHAR(6),
  main_genre VARCHAR(33),
  genres VARCHAR(401),
  image_url VARCHAR(64)
);


-- create table for artist_chart
CREATE TABLE artist_chart 
(
  artist_id VARCHAR(22),
  rank_score INT,
  peak_position INT,
  weeks_on_chart INT,
  week DATE
);


-- create table for artist_pop
CREATE TABLE artist_pop 
(
  artist_id VARCHAR(22),
  year_end_score INT,
  is_pop VARCHAR(5),
  year INT
);


-- create table for releases
CREATE TABLE releases 
(
  artist_id VARCHAR(22),
  album_id VARCHAR(22),
  release_date VARCHAR(10),
  release_date_precision VARCHAR(5),
  PRIMARY KEY(artist_id, album_id)
);


-- create table for songs
CREATE TABLE songs 
(
  song_id VARCHAR(22) PRIMARY KEY,
  song_name VARCHAR(194),
  billboard VARCHAR(112),
  artists VARCHAR(671),
  popularity INT,
  explicit VARCHAR(5),
  song_type VARCHAR(13)
);


-- create table for song_chart
CREATE TABLE song_chart 
(
  song_id VARCHAR(22),
  rank_score INT,
  peak_position INT,
  weeks_on_chart INT,
  week date
);


-- create table for song_pop
CREATE TABLE song_pop 
(
  song_id VARCHAR(22),
  year_end_score INT,
  is_pop VARCHAR(5),
  year INT
);


-- create table for tracks
CREATE TABLE tracks 
(
  song_id VARCHAR(22),
  album_id VARCHAR(22),
  track_number INT,
  release_date VARCHAR(10),
  release_date_precision VARCHAR(5),
  PRIMARY KEY(song_id, album_id)
);

-- create table for lyrics
CREATE TABLE lyrics 
(
    song_id VARCHAR(22) PRIMARY KEY,
    lyrics LONGTEXT
);