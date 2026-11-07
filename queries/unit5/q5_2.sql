-- Part A

SELECT m.match_id,
       m.match_label,
       mp.player_id
FROM matches m
LEFT JOIN match_participants mp ON m.match_id = mp.match_id;


SELECT m.match_id,
       m.match_label,
       mp.player_id
FROM matches m
INNER JOIN match_participants mp ON m.match_id = mp.match_id;


SELECT m.match_id,
       mp.match_id,
       COUNT(*) OVER () AS matches_excluded_by_inner_join
FROM matches m
LEFT JOIN match_participants mp ON m.match_id = mp.match_id
WHERE mp.match_id IS NULL;

-- Part B

SELECT m.match_id,
       m.match_label,
       mp.player_id
FROM match_participants mp
RIGHT JOIN matches m ON mp.match_id = m.match_id;


SELECT m.match_id,
       m.match_label,
       mp.player_id
FROM matches m
FULL OUTER JOIN match_participants mp ON m.match_id = mp.match_id;

-- Verify empty matches and orphaned participations

SELECT COUNT(DISTINCT m.match_id) FILTER (
                                          WHERE mp.match_id IS NULL) AS matches_no_participants,
       COUNT(DISTINCT mp.match_id) FILTER (
                                           WHERE m.match_id IS NULL) AS orphaned_participations
FROM matches m
FULL OUTER JOIN match_participants mp ON m.match_id = mp.match_id;

-- Part C:

SELECT m.match_id,
       m.match_label
FROM matches m
WHERE NOT EXISTS
    (SELECT 1
     FROM match_participants mp
     WHERE mp.match_id = m.match_id);


SELECT m.match_id,
       m.match_label
FROM matches m
EXCEPT
SELECT m.match_id,
       m.match_label
FROM matches m
JOIN match_participants mp on m.match_id = mp.match_id;