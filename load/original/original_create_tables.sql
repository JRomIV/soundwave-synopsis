-- create table for acoustic_features
CREATE TABLE `acoustic_features` (
  `song_id` varchar(22) DEFAULT NULL,
  `duration_ms` int(7) DEFAULT NULL,
  `key` int(2) DEFAULT NULL,
  `mode` int(1) DEFAULT NULL,
  `time_signature` int(1) DEFAULT NULL,
  `acousticness` decimal(11,6) DEFAULT NULL,
  `danceability` decimal(4,3) DEFAULT NULL,
  `energy` decimal(6,5) DEFAULT NULL,
  `instrumentalness` decimal(12,7) DEFAULT NULL,
  `liveness` decimal(5,4) DEFAULT NULL,
  `loudness` decimal(6,3) DEFAULT NULL,
  `speechiness` decimal(6,4) DEFAULT NULL,
  `valence` decimal(5,4) DEFAULT NULL,
  `tempo` decimal(6,3) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for albums
CREATE TABLE `albums` (
  `album_id` varchar(22) DEFAULT NULL,
  `name` varchar(292) DEFAULT NULL,
  `billboard` varchar(75) DEFAULT NULL,
  `artists` varchar(2228) DEFAULT NULL,
  `popularity` int(2) DEFAULT NULL,
  `total_tracks` int(3) DEFAULT NULL,
  `album_type` varchar(11) DEFAULT NULL,
  `image_url` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for album_cart
CREATE TABLE `album_chart` (
  `album_id` varchar(22) DEFAULT NULL,
  `rank_score` int(3) DEFAULT NULL,
  `peak_position` int(3) DEFAULT NULL,
  `weeks_on_chart` int(3) DEFAULT NULL,
  `week` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for album_pop
CREATE TABLE `album_pop` (
  `album_id` varchar(22) DEFAULT NULL,
  `year_end_score` int(5) DEFAULT NULL,
  `is_pop` varchar(5) DEFAULT NULL,
  `year` int(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for artists
CREATE TABLE `artists` (
  `artist_id` varchar(22) DEFAULT NULL,
  `name` varchar(91) DEFAULT NULL,
  `followers` varchar(8) DEFAULT NULL,
  `popularity` int(3) DEFAULT NULL,
  `artist_type` varchar(6) DEFAULT NULL,
  `main_genre` varchar(33) DEFAULT NULL,
  `genres` varchar(401) DEFAULT NULL,
  `image_url` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for artist_chart
CREATE TABLE `artist_chart` (
  `artist_id` varchar(22) DEFAULT NULL,
  `rank_score` int(4) DEFAULT NULL,
  `peak_position` int(4) DEFAULT NULL,
  `weeks_on_chart` int(4) DEFAULT NULL,
  `week` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for artist_pop
CREATE TABLE `artist_pop` (
  `artist_id` varchar(22) DEFAULT NULL,
  `year_end_score` int(6) DEFAULT NULL,
  `year` int(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for lyrics
CREATE TABLE `lyrics` (
  `song_id` varchar(22) COLLATE utf8_general_mysql500_ci NOT NULL,
  `lyrics` mediumtext COLLATE utf8_general_mysql500_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;


-- create table for releases
CREATE TABLE `releases` (
  `artist_id` varchar(22) DEFAULT NULL,
  `album_id` varchar(22) DEFAULT NULL,
  `release_date` varchar(10) DEFAULT NULL,
  `release_date_precision` varchar(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for songs
CREATE TABLE `songs` (
  `song_id` varchar(22) DEFAULT NULL,
  `song_name` varchar(194) DEFAULT NULL,
  `billboard` varchar(112) DEFAULT NULL,
  `artists` varchar(671) DEFAULT NULL,
  `popularity` int(2) DEFAULT NULL,
  `explicit` varchar(5) DEFAULT NULL,
  `song_type` varchar(13) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for song_chart
CREATE TABLE `song_chart` (
  `song_id` varchar(22) DEFAULT NULL,
  `rank_score` int(3) DEFAULT NULL,
  `peak_position` int(3) DEFAULT NULL,
  `weeks_on_chart` int(2) DEFAULT NULL,
  `week` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for song_pop
CREATE TABLE `song_pop` (
  `song_id` varchar(22) DEFAULT NULL,
  `year_end_score` int(4) DEFAULT NULL,
  `year` int(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- create table for tracks
CREATE TABLE `tracks` (
  `song_id` varchar(22) DEFAULT NULL,
  `album_id` varchar(22) DEFAULT NULL,
  `track_number` int(3) DEFAULT NULL,
  `release_date` varchar(10) DEFAULT NULL,
  `release_date_precision` varchar(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;