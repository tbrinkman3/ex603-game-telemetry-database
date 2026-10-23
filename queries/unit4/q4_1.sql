-- Platform-wide aggregate stats

SELECT COUNT(*) as total_score_count,
       SUM(score) as sum_score,
       AVG(score) as avg_score,
       MIN(score) as min_score,
       MAX(score) as max_score,
       COUNT(DISTINCT(player_id)) as players
FROM match_participants;

-- Producer event count

SELECT match_id,
       COUNT(*) AS event_count,
       ROUND(AVG(score), 2) AS avg_score
FROM match_participants
GROUP BY match_id
ORDER BY event_count DESC;

-- Volume threshold, 16 participant matches or higher quantify as a full match

select match_id,
       COUNT(*) AS event_count,
       ROUND(AVG(score), 2) as avg_score
FROM match_participants
GROUP BY match_id
HAVING count(*) >= 16
ORDER BY event_count DESC;

-- Two dimension

select m.server_region,
       COUNT(*) AS event_count,
       SUM(score) as sum_score,
       ROUND(AVG(score), 2) as avg_score,
       MIN(score) as min_score,
       MAX(score) as max_score
from match_participants mp
LEFT JOIN matches m ON mp.match_id = m.match_id
GROUP BY m.server_region
ORDER BY event_count DESC;