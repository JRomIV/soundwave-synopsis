-- artist table: converting followers column from VARCHAR into INT
-- A few rows were equal to 'none' converting the 'none' values into NULL
UPDATE artists
SET followers = NULL
WHERE followers = 'None';
    
-- converting the data type from VARCHAR to INT
ALTER TABLE artists MODIFY followers INT;

-- artist_pop: converting T/F into boolean values
UPDATE artist_pop
SET is_pop = CASE
	WHEN is_pop = 'True' THEN 1
    WHEN is_pop = 'False' THEN 0
    ELSE is_pop
END;

ALTER TABLE artist_pop MODIFY is_pop TINYINT;

-- album_pop: converting T/F into boolean values
UPDATE album_pop
SET is_pop = CASE
	WHEN is_pop = 'True' THEN 1
    WHEN is_pop = 'False' THEN 0
    ELSE is_pop
END;

ALTER TABLE album_pop MODIFY is_pop TINYINT;

-- song_pop: converting T/F into boolean values
UPDATE song_pop
SET is_pop = CASE
	WHEN is_pop = 'True' THEN 1
    WHEN is_pop = 'False' THEN 0
    ELSE is_pop
END;

ALTER TABLE song_pop MODIFY is_pop TINYINT;

-- songs: converting T/F into boolean values
UPDATE songs
SET explicit = CASE
	WHEN explicit = 'True' THEN 1
    WHEN explicit = 'False' THEN 0
    ELSE explicit
END;

ALTER TABLE songs MODIFY explicit TINYINT;

-- tracks: converting release_date from VARCHAR to DATE
-- creating release_date_standard column to have a correctly formatted column
ALTER TABLE tracks
ADD COLUMN release_date_standard VARCHAR(255);

UPDATE tracks
SET release_date_standard = release_date;

-- setting year/month values to the 1st/January if missing intial value
UPDATE tracks
SET release_date_standard = 
CASE
	WHEN CHAR_LENGTH(release_date_standard) = 4 THEN CONCAT(release_date_standard, '-01-01')
	WHEN CHAR_LENGTH(release_date_standard) = 7 THEN CONCAT(release_date_standard, '-01')
	ELSE release_date_standard
END;

-- converting new column into a date format
ALTER TABLE tracks
MODIFY COLUMN release_date_standard DATE;

-- songs: adding a extracted artist column to clean format
ALTER TABLE songs
ADD COLUMN artist_extracted VARCHAR(255);


UPDATE songs
SET artist_extracted = TRIM(BOTH "'" FROM SUBSTRING_INDEX(SUBSTRING_INDEX(artists, "': '", -1), "'}", 1));
