-- foreign-key indexes
CREATE INDEX idx_songs_artist_id  ON songs (artist_id);
CREATE INDEX idx_albums_artist_id ON albums (artist_id);
CREATE INDEX idx_tracks_album_id  ON tracks (album_id);
CREATE INDEX idx_releases_album_id ON releases (album_id);
CREATE INDEX idx_releases_artist_id ON releases (artist_id);
CREATE INDEX idx_tracks_song_id ON tracks (song_id);

-- time indexes
CREATE INDEX idx_songpop_year  ON song_pop (year);
CREATE INDEX idx_artistpop_year ON artist_pop (year);
CREATE INDEX idx_album_chart_week  ON album_chart (week);
CREATE INDEX idx_song_chart_week   ON song_chart (week);
CREATE INDEX idx_tracks_release_date_standard ON tracks (release_date_standard);

-- genre indexes
CREATE INDEX idx_artists_main_genre ON artists (main_genre);
CREATE INDEX idx_genres_main_genre  ON genres  (main_genre);
