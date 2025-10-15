USE musicoset;

-- create table for acoustic_features
DROP TABLE IF EXISTS acoustic_features;

CREATE TABLE acoustic_features 
(
  song_id varchar(35) NOT NULL,
  duration_ms int,
  `key` int,
  `mode` int,
  time_signature int,
  acousticness DOUBLE,
  danceability DOUBLE,
  energy DOUBLE,
  instrumentalness DOUBLE,
  liveness DOUBLE,
  loudness DOUBLE,
  speechiness DOUBLE,
  valence DOUBLE,
  tempo DOUBLE,
  PRIMARY KEY (song_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for album_chart
DROP TABLE IF EXISTS album_chart;

CREATE TABLE album_chart 
(
  album_id varchar(22) NOT NULL,
  rank_score int,
  peak_position int,
  weeks_on_chart int,
  `week` date
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for album_pop
DROP TABLE IF EXISTS album_pop;

CREATE TABLE album_pop 
(
  album_id varchar(22) NOT NULL,
  year_end_score int,
  is_pop tinyint,
  `year` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for albums
DROP TABLE IF EXISTS albums;

CREATE TABLE albums 

(
  album_id VARCHAR(22) NOT NULL,
  album_name VARCHAR(512),
  popularity INT,
  total_tracks INT,
  album_type VARCHAR(20),
  artist_id VARCHAR(75),
  PRIMARY KEY (album_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for artist_chart
DROP TABLE IF EXISTS artist_chart;

CREATE TABLE artist_chart 
(
  artist_id varchar(22),
  rank_score int,
  peak_position int,
  weeks_on_chart int,
  `week` date
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for artist_pop
DROP TABLE IF EXISTS artist_pop;

CREATE TABLE artist_pop 
(
  artist_id varchar(22),
  year_end_score int,
  is_pop tinyint,
  `year` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for artists
DROP TABLE IF EXISTS artists;

CREATE TABLE artists 
(
  artist_id varchar(22) NOT NULL,
  artist_name varchar(255),
  followers int,
  popularity int,
  artist_type varchar(6),
  genres varchar(401),
  main_genre varchar(50),
  PRIMARY KEY (artist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- create table for releases
DROP TABLE IF EXISTS releases;

CREATE TABLE releases 
(
  artist_id varchar(22) NOT NULL,
  album_id varchar(22) NOT NULL,
  release_date varchar(10),
  release_date_precision varchar(5),
  PRIMARY KEY (artist_id,album_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for song_chart
DROP TABLE IF EXISTS song_chart;

CREATE TABLE song_chart 
(
  song_id varchar(35),
  rank_score int,
  peak_position int,
  weeks_on_chart int,
  `week` date
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for song_pop
DROP TABLE IF EXISTS song_pop;

CREATE TABLE song_pop 
(
  song_id varchar(35),
  year_end_score int,
  is_pop tinyint,
  `year` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for songs
DROP TABLE IF EXISTS songs;

CREATE TABLE songs 
(
  song_id VARCHAR(35) NOT NULL,
  song_name VARCHAR(255),
  billboard VARCHAR(255),
  popularity INT,
  explicit TINYINT,
  song_type VARCHAR(13),
  artist_extracted TEXT,
  is_billboard TINYINT DEFAULT '0',
  artist_id VARCHAR(75),
  PRIMARY KEY (song_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for tracks
DROP TABLE IF EXISTS tracks;

CREATE TABLE tracks 
(
  song_id varchar(35) NOT NULL,
  album_id varchar(22) NOT NULL,
  track_number int,
  release_date varchar(10),
  release_date_precision varchar(5),
  release_date_standard date,
  PRIMARY KEY (song_id,album_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- create table for lyrics
DROP TABLE IF EXISTS lyrics;

CREATE TABLE lyrics 
(
  song_id VARCHAR(35) NOT NULL,
  lyrics LONGTEXT,
  PRIMARY KEY (song_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- create table for genres
DROP TABLE IF EXISTS genres;
CREATE TABLE genres
(
  main_genre   VARCHAR(50) PRIMARY KEY,
  parent_genre VARCHAR(50)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;