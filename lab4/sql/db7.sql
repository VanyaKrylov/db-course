SELECT memory, COUNT(*) AS mem FROM gpu GROUP BY memory
HAVING COUNT(*) > 2
ORDER BY mem;
