USE dev;

CREATE SCHEMA movies; 

CREATE TABLE movies.imdb_movies_rating (
    Poster_Link VARCHAR(MAX),
    Series_Title VARCHAR(MAX),
    Released_Year VARCHAR(10),
    Certificate VARCHAR(50),
    Runtime VARCHAR(50),
    Genre VARCHAR(200),
    IMDB_Rating DECIMAL(10,2),
    Overview VARCHAR(MAX),
    Meta_score INT,
    Director VARCHAR(200),
    Star1 VARCHAR(200),
    Star2 VARCHAR(200),
    Star3 VARCHAR(200),
    Star4 VARCHAR(200),
    No_of_Votes INT,
    Gross VARCHAR(20)
);