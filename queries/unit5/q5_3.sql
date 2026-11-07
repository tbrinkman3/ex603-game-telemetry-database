-- Count : 25

SELECT COUNT(m.match_id) AS row_count_match_mode
FROM match_modes m;

-- Count: 5

SELECT COUNT(gm.mode_id) AS row_count_game_mode
FROM game_modes gm;

-- 25 x 5 : 125 rows

SELECT *
FROM match_modes m
CROSS JOIN game_modes gm;

EXPLAIN ANALYZE
SELECT p.player_name,
       mp.match_id,
       m.scheduled_on
FROM players p
JOIN match_participants mp ON p.player_id = mp.player_id
JOIN matches m on mp.match_id = m.match_id;