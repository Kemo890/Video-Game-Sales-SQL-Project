/*
-Created a table in MySQL, loaded data from a CSV file into it, and did some basic exploratory data analysis.
-Completed basic data cleaning before hand by correcting some game names and converting the sales to millions.
-Dataset set from https://www.kaggle.com/gregorut/videogamesales
*/

# Creating a new table for the data
CREATE TABLE game_sales (
    ranking SMALLINT NOT NULL,
    name VARCHAR(132) NOT NULL,
    platform VARCHAR(8) NOT NULL,
    year VARCHAR(4),
    genre VARCHAR(12),
    publisher VARCHAR(38),
	na_sales INT,
    eu_sales INT,
    jp_sales INT,
    other_sales INT,
    global_sales INT,
    PRIMARY KEY (ranking)
);

# Loading video game sales from CSV file.
LOAD DATA INFILE 'vgsales.csv'
INTO TABLE game_sales
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

# Top 10 Publishers by Sales
SELECT 
    publisher,
    SUM(na_sales),
    SUM(eu_sales),
    SUM(jp_sales),
    SUM(other_sales),
    SUM(global_sales)
FROM
    game_sales
GROUP BY publisher
ORDER BY 6 DESC
LIMIT 10;
# Nintendo has the most sales with $1781200000 in sales

# Genres by Sales
SELECT 
    genre,
    SUM(na_sales),
    SUM(eu_sales),
    SUM(jp_sales),
    SUM(other_sales),
    SUM(global_sales)
FROM
    game_sales
GROUP BY genre
ORDER BY 6 DESC;
# The #1 genre in the dataset is Action with $1,687,800,000 in global sales

# Global sales by platform
SELECT 
    platform,
    SUM(global_sales)
FROM
    walmartcsv.game_sales
GROUP BY platform
ORDER BY 2 DESC;
# The platform with the most global sales is the PS2 with $1,219,890,000 in sales

# Top 5 years by global game sales
SELECT 
    year,
    SUM(global_sales)
FROM
    game_sales
GROUP BY year
ORDER BY 2 DESC
LIMIT 5;
# The year with the best sales for games was 2008 with $650,220,000 in sales
