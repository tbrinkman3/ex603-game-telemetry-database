-- Part A
-- Initial query - 22 count

SELECT player_id,
       match_id,
       disconnect_reason,
       COUNT(*) OVER () AS record_count
FROM match_participants
WHERE disconnect_reason != 'Network timeout';

-- Get count of all other statuses plus null - 188 count

SELECT player_id,
       match_id,
       disconnect_reason,
       COUNT(*) OVER () AS record_count
FROM match_participants
WHERE disconnect_reason IN ('Player quit',
                            'Client crash',
                            'Server restart')
  OR disconnect_reason IS NULL;

-- Fixed query - 188 count

SELECT player_id,
       match_id,
       disconnect_reason,
       COUNT(*) OVER () AS record_count
FROM match_participants
WHERE disconnect_reason != 'Network timeout'
  OR disconnect_reason IS NULL;

-- Part B
 -- SELECT player_id as PID,
--        match_id
-- FROM match_participants
-- WHERE PID >= 5;
 -- PRODUCES ERROR
 -- Started executing query at Line 1
-- column "pid" does not exist
-- LINE 2: ...ECT player_id as PID FROM match_participants WHERE PID >= 5;
-- ^
-- Total execution time: 00:00:00.001

SELECT player_id AS PID,
       match_id
FROM match_participants
WHERE player_id >= 8;

WITH pid_scope AS
  (select player_id AS PID,
          match_id
   FROM match_participants)
SELECT PID,
       match_id
FROM pid_scope
WHERE PID >= 8;