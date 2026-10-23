-- Part A

SELECT mp.match_id,
       COUNT(*) AS total_participants,
       SUM(CASE
               WHEN mp.participation_status <> 'finished' THEN 1
               ELSE 0
           END) AS disconnected_participants
FROM match_participants mp
GROUP BY mp.match_id
ORDER BY disconnected_participants DESC;

-- Part B

SELECT client_region,
       SUM(score) as score_total,
       CASE
           WHEN GROUPING(client_region) = 1 THEN 'grand_total'
           WHEN GROUPING(match_id) = 1 THEN 'region_subtotal'
       END AS row_type
FROM match_participants
GROUP BY ROLLUP(client_region, match_id)
HAVING GROUPING(client_region) = 1
OR GROUPING(match_id) = 1;

-- Part C
 WITH match_producers AS
  (SELECT match_id,
          ROUND(AVG(score), 2) AS avg_score,
          COUNT(*) as participants
   FROM match_participants
   GROUP BY match_id)
SELECT match_id,
       avg_score,
       participants
from match_producers
WHERE participants >= 16
ORDER BY avg_score DESC;