# Introduction
This analysis explores popular music thoughout the decades using a database contaning popular Billboard music and musical elements charted by Spotify. We dive into the most popular Artists, Albums, and Songs spanning from 1964 to 2018 while discovering any correlations we may find along the way. Provided below are vizualiztions and a Tableau Dashboard to follow along if so desired.


# Background
Music is an undeniable part of the human experience that not only enriches culture but is an expression of it. Naturally I am very interested in the topic and was excited when I came across this database that not only contained a large amount of music but the musical elements of each song. As a brief overview I will explore the most popular music across time and what attributes that may be associated with popularity. I will also explore if music has changed overtime and if we see fundemental differences between the very top songs and the rest of the charts. Specifically, this analysis will answer the following questions:
1. Who are the most prominent artists of all time?
2. Which albums are the most popular of all time?
3. What are the most popular songs of all time?
4. Have musical attributes changed across time?
5. Are there any musical elements that correlate with each other?


# Tools
### Dashboard
[Link to Tableau Public]
[Image of Dashboard]

### Technology Stack
I used a variety of tools to explore and gain experience with different methods:
- **Git/GitHub**: For version control and to share my insights
- **MySQL Workbench**: For database management and queries
- **Python/R**: To create a small script to calculate correlations
- **Tableau**: For all the data visualization
- **Visual Studio Code**: For file management and running Python/R scripts


# Analysis
In order to identify the most popular music I used a summation of **Year End Score** instead of **Popularity** which is based on recent plays and therefore recent popularity. **Year End Score** is a calculation derived from the combination of peak chart position and the amount of weeks it has been on the chart and was used as the primary metric for popularity in this analysis. For further clarification about the definitions used please reference the metadata file.


## 1. Who are the most prominent artists of all time?
#### A. Artists with highest Year End Score


This query provides a list of top 50 ranked Billboard Artists of all time.
``` sql
WITH cte AS (
SELECT
    DENSE_RANK() OVER(ORDER BY SUM(year_end_score) DESC) AS artist_rank,
    artist_name,
    main_genre,
    SUM(year_end_score) AS total_year_end_score
FROM
    artist_temp
GROUP BY
	artist_name,
    main_genre
)

SELECT
	*
FROM
	cte
WHERE
	artist_rank <= 50;
```

Here is a breakdown of the top 50 artists of all time:
- The dominate generes in the top 50 are Rock (38%), Pop (15%), and Country (14%).
- 50% of the top 10 belong to the rock genre
- Pink Floyd has significant lead in regards to score, even surpassing The Beatles by 100,000.  

![top_50_artists](assets\artists_50.PNG)


#### B. Longest trending artists

Another significant metric is to measure how long an artist has trended the charts. The following query lists the longest trending Billboard

``` sql
SELECT
    ROW_NUMBER() OVER (ORDER BY MAX(ac.weeks_on_chart) DESC) AS artist_rank,
	a.name,
    a.main_genre,
	MAX(ac.weeks_on_chart) AS weeks_on_chart,
    MIN(ac.week) AS first_week,
    MAX(ac.week) AS last_week
FROM
	artist_chart ac
LEFT JOIN
	artists a
    ON ac.artist_id = a.artist_id
WHERE
	a.name IS NOT NULL
    AND a.name != 'Various Artists'
GROUP BY
	a.name,
    a.main_genre
ORDER BY
	weeks_on_chart DESC
LIMIT
	50;
```


Key findings from the longest trending chart:
- The Beatles top this chart with a total of 1355 weeks of total trending. That is equivalent to 25 years straight!
- 60% of the artists in the top 10 have been trending since the 1970's.


<div style="height: 400px; overflow-y: auto;">

| Rank | Name                           | Weeks on Chart | First Week | Last Week   |
|------|--------------------------------|----------------|------------|-------------|
| 1    | The Beatles                    | 1355           | 1964-01-18 | 2018-12-29  |
| 2    | Eminem                         | 1125           | 1999-02-27 | 2018-12-29  |
| 3    | Pink Floyd                     | 1074           | 1967-12-02 | 2018-12-29  |
| 4    | Drake                          | 1041           | 2009-05-23 | 2018-12-29  |
| 5    | Prince                         | 868            | 1978-10-28 | 2018-12-29  |
| 6    | Herb Alpert & The Tijuana Brass| 774            | 1965-01-16 | 1984-10-27  |
| 7    | Michael Jackson                | 762            | 1971-10-30 | 2018-12-29  |
| 8    | Taylor Swift                   | 722            | 2006-09-23 | 2018-12-29  |
| 9    | Led Zeppelin                   | 665            | 1969-02-15 | 2018-11-17  |
| 10   | Bruno Mars                     | 663            | 2010-08-07 | 2018-12-29  |
| 11   | Whitney Houston                | 641            | 1985-03-30 | 2018-07-21  |
| 12   | Metallica                      | 630            | 1984-09-29 | 2018-12-29  |
| 13   | Adele                          | 611            | 2008-06-28 | 2018-12-29  |
| 14   | U2                             | 606            | 1981-03-14 | 2018-03-24  |
| 15   | Ed Sheeran                     | 584            | 2012-06-30 | 2018-12-29  |
| 16   | Guns N' Roses                  | 584            | 1987-08-29 | 2018-12-29  |
| 17   | Bill Cosby                     | 574            | 1964-06-27 | 1983-03-19  |
| 18   | Linkin Park                    | 555            | 1990-10-06 | 2018-11-03  |
| 19   | Bob Marley & The Wailers       | 553            | 1975-05-10 | 2018-12-29  |
| 20   | Zac Brown Band                 | 549            | 2008-10-04 | 2018-12-01  |
| 21   | Journey                        | 543            | 1975-05-03 | 2018-12-29  |
| 22   | Chicago                        | 519            | 1969-05-17 | 2017-01-28  |
| 23   | Imagine Dragons                | 505            | 1979-08-11 | 2018-12-29  |
| 24   | The Police                     | 468            | 1979-02-24 | 2007-10-13  |
| 25   | Blake Shelton                  | 458            | 2001-05-26 | 2018-12-15  |
| 26   | Coldplay                       | 453            | 1969-12-27 | 2018-12-22  |
| 27   | Kendrick Lamar                 | 442            | 2003-03-15 | 2018-12-29  |
| 28   | Fleetwood Mac                  | 431            | 1969-02-08 | 2018-12-29  |
| 29   | Beyoncé                        | 427            | 1973-11-03 | 2018-11-03  |
| 30   | Luke Bryan                     | 426            | 2007-08-18 | 2018-10-27  |
| 31   | The Weeknd                     | 422            | 1983-04-30 | 2018-12-29  |
| 32   | The Rolling Stones             | 420            | 1964-05-02 | 2018-11-17  |
| 33   | Eagles                         | 417            | 1972-06-03 | 2018-12-29  |
| 34   | J. Cole                        | 415            | 2010-10-02 | 2018-12-29  |
| 35   | Phil Collins                   | 413            | 1981-03-14 | 2017-01-28  |
| 36   | Nirvana                        | 410            | 1991-10-12 | 2018-12-29  |
| 37   | Bob Seger                      | 408            | 1968-12-21 | 2018-12-29  |
| 38   | The Monkees                    | 393            | 1966-09-10 | 2016-09-03  |
| 39   | Kanye West                     | 381            | 1970-08-15 | 2018-11-17  |
| 40   | Florida Georgia Line           | 380            | 2012-12-22 | 2018-11-10  |
| 41   | Michael Bublé                  | 377            | 1969-06-14 | 2018-12-29  |
| 42   | Nickelback                     | 368            | 1976-09-25 | 2018-03-10  |
| 43   | Queen                          | 364            | 1974-05-11 | 2018-12-29  |
| 44   | Bruce Springsteen              | 356            | 1975-07-26 | 2018-12-29  |
| 45   | Katy Perry                     | 356            | 1977-10-01 | 2018-02-10  |
| 46   | Mumford & Sons                 | 350            | 2010-03-06 | 2018-12-29  |
| 47   | Kid Rock                       | 345            | 1999-01-16 | 2018-10-27  |
| 48   | Madonna                        | 343            | 1983-09-03 | 2016-09-10  |
| 49   | Michael Bolton                 | 343            | 1983-05-07 | 2017-03-04  |
| 50   | AC/DC                          | 338            | 1977-08-13 | 2018-12-29  |

</div>



## 2. Most popular albums of all time
####  A. Albums with the highest Year End Score
To dive further into popular music, I query the temp table for the highest scored albums of all time. Included is the release date and genre of these albums. 
```sql
WITH cte AS(
SELECT
	DENSE_RANK() OVER(ORDER BY SUM(year_end_score) DESC) AS album_rank,
    album_name,
    artist_name,
    main_genre,
    MIN(YEAR(release_date)) AS release_date,
    SUM(year_end_score) AS total_year_end_score
FROM
	temp_albums
GROUP BY
    album_name,
    artist_name,
    main_genre
)

SELECT
	*
FROM
	cte
WHERE
	album_rank <= 50;
```

Key findings for the top 50 albums of all time:
- The Dark Side of the Moon is by far the higest ranked album of all time. Doubling the number 2 spot (Journey's Greatest Hits).
- When combining scores based on artist, Eminem would take the #2 spot with a total score of 425,006.
- Notably The Beatles have 3 albums in the top 50, followed by Eminem with 3 albums and Micheal Jackson with 2 albums. 



![top_50_albums](assets\albums_50.PNG)

#### B. Longest trending albums
```sql
SELECT
	ta.album_name AS album_name,
    ta.artist_name AS artist_name,
	MAX(ac.weeks_on_chart) AS weeks_on_chart,
    MIN(ac.week) AS first_week,
    MAX(ac.week) AS last_week
FROM
	album_chart ac
LEFT JOIN
	temp_albums ta
    ON ac.album_id = ta.album_id
GROUP BY
	album_name,
    artist_name
ORDER BY
	weeks_on_chart DESC
LIMIT
	50;
```

Key findings about the 50 longest trending albums:
- Pink Floyd's "The Darkside of the Moon" trended for a total of 940 weeks. This is equal to about 18 years over the span of 45 years. 
- 50% of albums on this chart started trending past the year 2000.
- "Greatest Hits" albums for various artists appeared 6 times in the top 50. 
 

<div style="height: 400px; overflow-y: auto;">

| Rank | Name                           | Weeks on Chart | First Week | Last Week   |
|------|--------------------------------|----------------|------------|-------------|
| 1    | The Beatles                    | 1355           | 1964-01-18 | 2018-12-29  |
| 2    | Eminem                         | 1125           | 1999-02-27 | 2018-12-29  |
| 3    | Pink Floyd                     | 1074           | 1967-12-02 | 2018-12-29  |
| 4    | Drake                          | 1041           | 2009-05-23 | 2018-12-29  |
| 5    | Prince                         | 868            | 1978-10-28 | 2018-12-29  |
| 6    | Herb Alpert & The Tijuana Brass| 774            | 1965-01-16 | 1984-10-27  |
| 7    | Michael Jackson                | 762            | 1971-10-30 | 2018-12-29  |
| 8    | Taylor Swift                   | 722            | 2006-09-23 | 2018-12-29  |
| 9    | Led Zeppelin                   | 665            | 1969-02-15 | 2018-11-17  |
| 10   | Bruno Mars                     | 663            | 2010-08-07 | 2018-12-29  |
| 11   | Whitney Houston                | 641            | 1985-03-30 | 2018-07-21  |
| 12   | Metallica                      | 630            | 1984-09-29 | 2018-12-29  |
| 13   | Adele                          | 611            | 2008-06-28 | 2018-12-29  |
| 14   | U2                             | 606            | 1981-03-14 | 2018-03-24  |
| 15   | Ed Sheeran                     | 584            | 2012-06-30 | 2018-12-29  |
| 16   | Guns N' Roses                  | 584            | 1987-08-29 | 2018-12-29  |
| 17   | Bill Cosby                     | 574            | 1964-06-27 | 1983-03-19  |
| 18   | Linkin Park                    | 555            | 1990-10-06 | 2018-11-03  |
| 19   | Bob Marley & The Wailers       | 553            | 1975-05-10 | 2018-12-29  |
| 20   | Zac Brown Band                 | 549            | 2008-10-04 | 2018-12-01  |
| 21   | Journey                        | 543            | 1975-05-03 | 2018-12-29  |
| 22   | Chicago                        | 519            | 1969-05-17 | 2017-01-28  |
| 23   | Imagine Dragons                | 505            | 1979-08-11 | 2018-12-29  |
| 24   | The Police                     | 468            | 1979-02-24 | 2007-10-13  |
| 25   | Blake Shelton                  | 458            | 2001-05-26 | 2018-12-15  |
| 26   | Coldplay                       | 453            | 1969-12-27 | 2018-12-22  |
| 27   | Kendrick Lamar                 | 442            | 2003-03-15 | 2018-12-29  |
| 28   | Fleetwood Mac                  | 431            | 1969-02-08 | 2018-12-29  |
| 29   | Beyoncé                        | 427            | 1973-11-03 | 2018-11-03  |
| 30   | Luke Bryan                     | 426            | 2007-08-18 | 2018-10-27  |
| 31   | The Weeknd                     | 422            | 1983-04-30 | 2018-12-29  |
| 32   | The Rolling Stones             | 420            | 1964-05-02 | 2018-11-17  |
| 33   | Eagles                         | 417            | 1972-06-03 | 2018-12-29  |
| 34   | J. Cole                        | 415            | 2010-10-02 | 2018-12-29  |
| 35   | Phil Collins                   | 413            | 1981-03-14 | 2017-01-28  |
| 36   | Nirvana                        | 410            | 1991-10-12 | 2018-12-29  |
| 37   | Bob Seger                      | 408            | 1968-12-21 | 2018-12-29  |
| 38   | The Monkees                    | 393            | 1966-09-10 | 2016-09-03  |
| 39   | Kanye West                     | 381            | 1970-08-15 | 2018-11-17  |
| 40   | Florida Georgia Line           | 380            | 2012-12-22 | 2018-11-10  |
| 41   | Michael Bublé                  | 377            | 1969-06-14 | 2018-12-29  |
| 42   | Nickelback                     | 368            | 1976-09-25 | 2018-03-10  |
| 43   | Queen                          | 364            | 1974-05-11 | 2018-12-29  |
| 44   | Bruce Springsteen              | 356            | 1975-07-26 | 2018-12-29  |
| 45   | Katy Perry                     | 356            | 1977-10-01 | 2018-02-10  |
| 46   | Mumford & Sons                 | 350            | 2010-03-06 | 2018-12-29  |
| 47   | Kid Rock                       | 345            | 1999-01-16 | 2018-10-27  |
| 48   | Madonna                        | 343            | 1983-09-03 | 2016-09-10  |
| 49   | Michael Bolton                 | 343            | 1983-05-07 | 2017-03-04  |
| 50   | AC/DC                          | 338            | 1977-08-13 | 2018-12-29  |

</div>


## 3. Most popular Songs of all time
#### A. Songs with the highest Year End Score

This query utilizes the temp_songs table created in order to minimize the amount of joins required to obtain the genre. A CTE was then used to filter the desired amount of songs.
```sql
WITH cte AS(
SELECT
	DENSE_RANK() OVER(ORDER BY SUM(year_end_score) DESC) AS song_rank,
    song_name,
    artist_name,
    main_genre,
    MIN(YEAR(release_date)) AS release_date,
    SUM(year_end_score) AS total_year_end_score
FROM
	temp_songs
GROUP BY
    song_name,
    artist_name,
    main_genre
)
    
SELECT
	*
FROM
	cte
WHERE
	song_rank <= 50;
```

Here is what we found about the top 50 songs of all time:
- Pop songs appear 17 times in the top 50 followed by Rock at 15 occurences.
- The most popular song is Radioactive by Imagine Dragons, being the only song to break 5 digits in score.

![top_50_songs](assets\songs_50.PNG)

#### B. Longest trending songs
This query obtains the song and artist name from the temp table created previously. The trending time frame along with the length was also calculated via aggregate functions from the song_chart table.
```sql
SELECT
    ts.song_name,
    ts.artist_name,
	MAX(sc.weeks_on_chart) AS weeks_on_chart,
    MIN(week) AS first_week,
    MAX(week) AS last_week
FROM
	song_chart sc
LEFT JOIN
	temp_songs ts
    ON ts.song_id = sc.song_id
GROUP BY
    ts.song_name,
    ts.artist_name
ORDER BY
	weeks_on_chart DESC
LIMIT
	100;
```

Song chart appears to be dominated by Pop. A lot of these songs are more recent.

<div style="height: 400px; overflow-y: auto;">

| Rank       | song_name                                               | artist_name             | weeks_on_chart | first_week   | last_week   |
|------------|---------------------------------------------------------|-------------------------|----------------|--------------|-------------|
| 1          | Radioactive                                             | Imagine Dragons         | 87             | 2012-08-18   | 2014-05-10  |
| 2          | Sail                                                    | AWOLNATION              | 79             | 2011-09-03   | 2014-03-22  |
| 3          | I'm Yours                                               | Jason Mraz              | 76             | 2008-05-03   | 2009-10-10  |
| 4          | How Do I Live                                           | LeAnn Rimes             | 69             | 1997-06-21   | 1998-10-10  |
| 5          | Counting Stars                                          | OneRepublic             | 68             | 2013-07-06   | 2014-10-18  |
| 6          | Rolling in the Deep                                     | Adele                   | 65             | 2010-12-25   | 2012-04-14  |
| 7          | Before He Cheats                                        | Carrie Underwood        | 64             | 2006-09-16   | 2007-12-01  |
| 8          | You And Me                                              | Lifehouse               | 62             | 2005-02-12   | 2006-04-22  |
| 9          | Ho Hey                                                  | The Lumineers           | 62             | 2012-06-23   | 2013-08-24  |
| 10         | Demons                                                  | Imagine Dragons         | 61             | 2013-01-26   | 2014-07-05  |
| 11         | Need You Now                                            | Lady Antebellum         | 60             | 2009-08-29   | 2010-10-16  |
| 12         | Macarena (Bayside Boys Mix) - (Tribute to Los Del Rio)  | Studio Allstars         | 60             | 1995-08-03   | 1997-02-22  |
| 13         | Baby Got Back                                           | Sir Mix-A-Lot           | 56             | 1992-05-02   | 1993-07-17  |
| 14         | How You Remind Me                                       | Nickelback              | 54             | 2001-08-18   | 2003-09-08  |
| 15         | Sugar, We're Goin Down                                  | Fall Out Boy            | 54             | 2005-06-04   | 2006-12-30  |
| 16         | Hey, Soul Sister                                        | Train                   | 54             | 2009-10-17   | 2011-04-02  |
| 17         | Take Me To Church                                       | Hozier                  | 53             | 2014-06-21   | 2015-09-26  |
| 18         | Hanging By A Moment                                     | Lifehouse               | 53             | 2000-12-30   | 2002-11-23  |
| 19         | Love Story                                              | Taylor Swift            | 53             | 2008-09-27   | 2009-12-05  |
| 20         | Dynamite                                                | Taio Cruz               | 53             | 2010-05-15   | 2011-09-24  |
| 21         | I Gotta Feeling                                         | Black Eyed Peas         | 53             | 2009-06-27   | 2010-06-26  |
| 22         | Not Afraid                                              | Eminem                  | 53             | 2010-05-22   | 2011-05-21  |
| 23         | Closer                                                  | The Chainsmokers        | 53             | 2016-08-20   | 2017-08-19  |
| 24         | Somebody That I Used To Know                            | Gotye                   | 53             | 2011-11-19   | 2013-11-10  |
| 25         | Lights                                                  | Ellie Goulding          | 53             | 2011-09-24   | 2013-09-14  |
| 26         | Blurred Lines                                           | Robin Thicke            | 53             | 2013-03-30   | 2014-03-29  |
| 27         | Here Without You                                        | 3 Doors Down            | 53             | 2003-05-31   | 2004-05-29  |
| 28         | We Belong Together                                      | Mariah Carey            | 53             | 2005-03-26   | 2006-03-25  |
| 29         | Low                                                     | Flo Rida                | 53             | 2007-10-06   | 2008-10-04  |
| 30         | See You Again                                           | Wiz Khalifa             | 53             | 2015-04-25   | 2016-04-23  |
| 31         | We Are Young                                            | fun.                    | 53             | 2011-12-10   | 2013-12-01  |
| 32         | Uptown Funk                                             | Mark Ronson             | 53             | 2014-11-08   | 2016-11-07  |
| 33         | Bad Day                                                 | Daniel Powter           | 53             | 2005-12-03   | 2007-11-17  |
| 34         | Don't Speak                                             | No Doubt                | 53             | 1996-08-10   | 1998-08-15  |
| 35         | Whoomp! There It Is                                     | Tag Team                | 53             | 1993-05-29   | 1995-05-20  |
| 36         | It Wasn't Me                                            | Shaggy                  | 53             | 2000-08-19   | 2002-08-03  |
| 37         | Kryptonite                                              | 3 Doors Down            | 53             | 2000-04-08   | 2001-04-07  |
| 38         | If I Die Young                                          | The Band Perry          | 53             | 2010-07-24   | 2011-12-10  |
| 39         | Shut Up and Dance                                       | WALK THE MOON           | 53             | 2014-11-22   | 2015-11-28  |
| 40         | Thunder                                                 | Imagine Dragons         | 52             | 2017-05-20   | 2018-05-05  |
| 41         | How's It Going to Be                                    | Third Eye Blind         | 52             | 1997-12-06   | 1998-11-28  |
| 42         | Meant To Be                                             | 2017 Dynamo Hitz        | 52             | 2017-11-11   | 2018-10-27  |
| 43         | CAN’T STOP THE FEELING!                                 | Rockabye Baby!          | 52             | 2016-05-28   | 2017-05-20  |
| 44         | That's What I Like                                      | Bruno Mars              | 52             | 2016-12-10   | 2018-01-20  |
| 45         | Say You Won't Let Go                                    | James Arthur            | 52             | 2016-11-12   | 2017-11-04  |
| 46         | Stitches                                                | Shawn Mendes            | 52             | 2015-06-13   | 2016-06-04  |
| 47         | Truly Madly Deeply                                      | Savage Garden           | 52             | 1997-12-06   | 1998-11-28  |
| 48         | Believer                                                | Imagine Dragons         | 52             | 2017-02-25   | 2018-02-10  |
| 49         | Stressed Out                                            | Twenty One Pilots       | 52             | 2015-05-16   | 2016-10-01  |
| 50         | Trap Queen                                              | Fetty Wap               | 52             | 2015-02-07   | 2016-01-30  |
</div>


## 4. What are the correlations?
```r
library(dplyr)

# import data
temp_attributes <- read.csv("temp_attributes.csv")

# create a correlation matrix
numeric_attributes <- select(temp_attributes, -song_name, -song_type, -release_date_standard, -song_id)
correlations <- cor(numeric_attributes, use = "everything", method = "pearson")

# export csv
write.csv(correlations,"correlations.csv")
```

```python
import pandas as pd

# import data
temp_attributes = pd.read_csv('temp_attributes.csv')

# create a correlation matrix
numeric_attributes = temp_attributes.drop(columns = ['song_name', 'song_type', 'release_date_standard', 'song_id'])
correlations = numeric_attributes.corr(method = 'pearson')

# export csv
correlations.to_csv('correlations.csv')
```

[Correlation Matrix]

Correlations weren't the strongest although there are some notable mentions Loundness Energy having the clearest positive correlation out of the whole dateset. We also see a strong negative correlation with Energy Acousticness indicating acousticness associated with less energy. 

## 5. Musical Attributes over time
```sql
WITH cte AS(
SELECT
    RANK() OVER(PARTITION BY YEAR(t.release_date_standard) ORDER BY SUM(sp.year_end_score) DESC) AS song_rank,
    sp.song_id AS id,
    YEAR(t.release_date_standard) AS release_date_standard,
    s.explicit,
    SUM(sp.year_end_score) AS total_year_end_score
FROM
    song_pop sp
LEFT JOIN
	tracks t
    ON t.song_id = sp.song_id
LEFT JOIN
	songs s
    ON sp.song_id = s.song_id
GROUP BY
    sp.song_id,
    YEAR(t.release_date_standard),
	s.explicit
)
SELECT
	song_rank,
    release_date_standard,
    explicit,
    ac.*,
    ac.duration_ms/60000 AS duration_min
FROM
	cte
LEFT JOIN
	acoustic_features ac
    ON ac.song_id = cte.id
WHERE
	song_rank <= 100
    AND release_date_standard >= 1964;
```
[Acoustic Image]

The above chart spans how these different attributes have changes over time. This also compares the difference betweent the top 100 billboard songs and the rest of Billboard songs that made the chart. 

# Conclusions
## Insights
Amount to how many bulllets on top
1. A
2. 
3.
4.
5.

## Closing Thoughts
