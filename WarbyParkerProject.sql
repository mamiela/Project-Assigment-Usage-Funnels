 -- What columns does the table have?\
SELECT *\
FROM survey\
LIMIT 10;\
-- What is the number of responses for each question? \
SELECT question, COUNT(DISTINCT user_id)\
FROM survey\
GROUP BY 1;\
-- What are the column names? (Three tables)\
SELECT *\
FROM home_try_on\
LIMIT 5;\
SELECT *\
FROM quiz\
LIMIT 5;\
SELECT *\
FROM purchase\
LIMIT 5;\
--Combine three tables with LEFT JOIN\
SELECT DISTINCT q.user_id,\
     h.user_id IS NOT NULL AS 'is_home_try_on',\
     h.number_of_pairs,\
     p.user_id IS NOT NULL AS 'is_purchase'\
  FROM quiz AS 'q'\
  LEFT JOIN home_try_on AS 'h'\
    ON h.user_id = q.user_id\
  LEFT JOIN purchase AS 'p'\
    ON p.user_id = h.user_id\
LIMIT 10;\
--Purchase by number_of_pairs
WITH funnels AS (SELECT DISTINCT q.user_id,\
     h.user_id IS NOT NULL AS 'is_home_try_on',\
     h.number_of_pairs AS 'number_of_pairs',\
     p.user_id IS NOT NULL AS 'is_purchase'\
  FROM quiz AS 'q'\
  LEFT JOIN home_try_on AS 'h'\
    ON h.user_id = q.user_id\
  LEFT JOIN purchase AS 'p'\
    ON p.user_id = h.user_id)\
SELECT DISTINCT number_of_pairs, COUNT(DISTINCT user_id), SUM(is_purchase)\
FROM funnels\
GROUP BY 1;\
--Purchase by is_home_try_on
WITH funnels AS (SELECT DISTINCT q.user_id,\
     h.user_id IS NOT NULL AS 'is_home_try_on',\
     h.number_of_pairs AS 'number_of_pairs',\
     p.user_id IS NOT NULL AS 'is_purchase'\
  FROM quiz AS 'q'\
  LEFT JOIN home_try_on AS 'h'\
    ON h.user_id = q.user_id\
  LEFT JOIN purchase AS 'p'\
    ON p.user_id = h.user_id)\
SELECT DISTINCT is_home_try_on, COUNT(DISTINCT user_id), SUM(is_purchase)\
FROM funnels\
GROUP BY 1;\
--The most common results of the style quiz.\
SELECT DISTINCT style, COUNT(DISTINCT user_id)\
FROM quiz\
GROUP BY 1;\
-- The most common types of purchase made.\
SELECT DISTINCT style, COUNT(DISTINCT user_id)\
FROM purchase\
GROUP BY 1;\
-- The most common color\
SELECT DISTINCT color, COUNT(DISTINCT user_id)\
FROM purchase\
GROUP BY 1\
ORDER BY 2 DESC;\
--Price
SELECT DISTINCT price, COUNT(DISTINCT user_id)\
FROM purchase\
GROUP BY 1\
ORDER BY 2 DESC;\
	}