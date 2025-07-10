# Some Analytics queries ran on the `imdb_movies_rating` table on AWS redshift

---

### **1. Top 10 Movies by IMDB Rating**

```sql
SELECT Series_Title, Released_Year, IMDB_Rating, Director
FROM movies.imdb_movies_rating
WHERE IMDB_Rating IS NOT NULL
ORDER BY IMDB_Rating DESC
LIMIT 10;
```

**Sample Output**

| Series\_Title   | Released\_Year | IMDB\_Rating | Director          |
| --------------- | -------------- | ------------ | ----------------- |
| The Shawshank   | 1994           | 9.3          | Frank Darabont    |
| The Godfather   | 1972           | 9.2          | Francis Coppola   |
| The Dark Knight | 2008           | 9.0          | Christopher Nolan |
| Inception       | 2010           | 8.8          | Christopher Nolan |

---

### **2. Most Common Genres**

```sql
SELECT Genre, COUNT(*) AS count
FROM movies.imdb_movies_rating
GROUP BY Genre
ORDER BY count DESC
LIMIT 10;
```

**Sample Output**

| Genre    | count |
| -------- | ----- |
| Drama    | 250   |
| Action   | 180   |
| Comedy   | 160   |
| Thriller | 130   |

---

### **3. Yearly Movie Count**

```sql
SELECT Released_Year, COUNT(*) AS movies_released
FROM movies.imdb_movies_rating
GROUP BY Released_Year
ORDER BY Released_Year;
```

**Sample Output**

| Released\_Year | movies\_released |
| -------------- | ---------------- |
| 1990           | 18               |
| 2000           | 22               |
| 2010           | 35               |
| 2020           | 40               |

---

### **4. Highest Grossing Movies**

```sql
SELECT Series_Title, Gross, Released_Year
FROM movies.imdb_movies_rating
WHERE Gross IS NOT NULL
ORDER BY Gross DESC
LIMIT 10;
```

**Sample Output**

| Series\_Title     | Gross | Released\_Year |
| ----------------- | ----- | -------------- |
| Avatar            | 2.8B  | 2009           |
| Avengers: Endgame | 2.7B  | 2019           |
| Titanic           | 2.2B  | 1997           |

---

### **5. Directors with Most Movies**

```sql
SELECT Director, COUNT(*) AS movie_count
FROM movies.imdb_movies_rating
GROUP BY Director
ORDER BY movie_count DESC
LIMIT 10;
```

**Sample Output**

| Director          | movie\_count |
| ----------------- | ------------ |
| Steven Spielberg  | 18           |
| Christopher Nolan | 10           |
| Martin Scorsese   | 9            |

---

### **6. Top Stars by Total Votes**

```sql
SELECT Star1 AS Star, SUM(No_of_votes) AS total_votes
FROM movies.imdb_movies_rating
GROUP BY Star1
ORDER BY total_votes DESC
LIMIT 10;
```

**Sample Output**

| Star              | total\_votes |
| ----------------- | ------------ |
| Leonardo DiCaprio | 5,300,000    |
| Tom Hanks         | 4,800,000    |

---

### **7. Average IMDB Rating by Genre**

```sql
SELECT Genre, ROUND(AVG(IMDB_Rating), 2) AS avg_rating
FROM movies.imdb_movies_rating
GROUP BY Genre
ORDER BY avg_rating DESC;
```

**Sample Output**

| Genre    | avg\_rating |
| -------- | ----------- |
| Mystery  | 8.2         |
| Drama    | 8.0         |
| Thriller | 7.9         |

---

### **8. Certification Distribution**

```sql
SELECT Certificate, COUNT(*) AS count
FROM movies.imdb_movies_rating
GROUP BY Certificate
ORDER BY count DESC;
```

**Sample Output**

| Certificate | count |
| ----------- | ----- |
| PG-13       | 200   |
| R           | 180   |
| PG          | 75    |

---

### **9. Movies with Highest Meta Score**

```sql
SELECT Series_Title, Meta_score, Released_Year
FROM movies.imdb_movies_rating
WHERE Meta_score IS NOT NULL
ORDER BY Meta_score DESC
LIMIT 10;
```

**Sample Output**

| Series\_Title | Meta\_score | Released\_Year |
| ------------- | ----------- | -------------- |
| The Godfather | 100         | 1972           |
| Citizen Kane  | 100         | 1941           |

---

### **10. Average Gross by Year**

```sql
SELECT Released_Year, ROUND(AVG(Gross), 2) AS avg_gross
FROM movies.imdb_movies_rating
WHERE Gross IS NOT NULL
GROUP BY Released_Year
ORDER BY Released_Year;
```

**Sample Output**

| Released\_Year | avg\_gross |
| -------------- | ---------- |
| 1990           | 120M       |
| 2000           | 180M       |
| 2010           | 220M       |

