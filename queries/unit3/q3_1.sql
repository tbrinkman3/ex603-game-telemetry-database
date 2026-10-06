-- 3.1 Establish what the data contains
-- 1. Find active, highly rated producers. Sorted and returning the first ten.
-- Need to find the appendix

SELECT match_id,
       match_label,
       player_count
FROM matches
WHERE is_ranked = 'True'
  AND player_count >= 8
ORDER BY player_count DESC
LIMIT 10;

-- 2. Finds all possible event statuses

SELECT DISTINCT(participation_status)
FROM match_participants;

-- 3. Filter the events in two different ways. Write: one query that filters a numeric range, and one query that filters using an explicit list of values with IN.
 -- Find players in matches who scored over 15.5.

SELECT player_id,
       match_id,
       match_id,
       score
FROM match_participants
WHERE score > 15.5;

-- Get all players in matches that did not occur in South America or the European Union

SELECT player_id,
       match_id,
       client_region
FROM match_participants
WHERE client_region NOT IN ('SA',
                            'EU');

-- 4. Work with text and missing values.
-- LIKE pattern, get all players with gamertags containing a number starting with 2

SELECT gamertag,
       player_name
FROM players
WHERE gamertag LIKE 'player2%';

-- Find replace null disconnect reason identifying Null value as a did not disconnect value.

SELECT player_id,
       match_id,
       COALESCE(disconnect_reason, 'Did not disconnect') AS disconnect_reason
FROM match_participants;

-- Compute xp_points earned by match

SELECT p.player_name,
       mp.match_id,
       ROUND(mp.xp_multiplier * mp.score) AS xp_points
FROM match_participants mp
JOIN players p ON p.player_id = mp.player_id
ORDER BY xp_points DESC;