--1. Count the Number of Movies vs TV Shows
SELECT 
    type,
    COUNT(*) FROM netflix
GROUP BY 1;

--2. Find the Most Common Rating for Movies and TV Shows
WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS ranking
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE ranking = 1;

--3. List All Movies Released in a Specific Year (e.g., 2020)
SELECT * 
FROM netflix
WHERE release_year = 2020;

--4. Find the Top 5 Countries with the Most Content on Netflix
SELECT * 
FROM
(
    SELECT 
        country,
        COUNT(*) AS total_content
    FROM netflix
    GROUP BY country
) AS t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;

--5. Identify the Longest Movie
SELECT 
    *
FROM netflix
WHERE type = 'Movie'
ORDER BY duration DESC 
    limit 1;

--6. Find Content Added in the Last 5 Years
SELECT *
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURRENT_DATE(), INTERVAL 5 YEAR);

--7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'
SELECT *
    FROM netflix
WHERE director = 'Rajiv Chilaka';

--8. List All TV Shows with More Than 5 Seasons
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND duration > 5;

--9.Count the Number of Content Items in Each Genre
SELECT 
    COUNT(*) AS total_content
FROM netflix
GROUP BY genre;

--10.Find each year and the average numbers of content release in India on netflix.
SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY total_release DESC
LIMIT 5;

--11. List All Movies that are Documentaries
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';

--12. Find All Content Without a Director
SELECT * 
FROM netflix
WHERE director IS NULL;

--13 Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
SELECT *
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > YEAR(CURRENT_DATE()) - 10;

--14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India
SELECT 
    actor,
    COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;



