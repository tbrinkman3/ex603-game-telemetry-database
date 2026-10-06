--Participants in matches with a network timeout
 -- Subquery example

SELECT participation_id,
       player_id,
       match_id
FROM match_participants
WHERE match_id IN
      (SELECT match_id
       FROM match_participants
       WHERE disconnect_reason = 'Network timeout');

-- CTE Example
 WITH dc_match_id AS
   (SELECT match_id
    FROM match_participants
    WHERE disconnect_reason = 'Network timeout')
SELECT participation_id,
       player_id,
       match_id
FROM match_participants
WHERE match_id IN
      (SELECT *
       FROM dc_match_id);

-- EXISTS subquery, matches participant id once

SELECT participation_id,
       player_id,
       match_id
FROM match_participants AS mp
WHERE EXISTS
      (SELECT 1
       FROM match_participants AS dc_mp
       WHERE mp.match_id = dc_mp.match_id
          AND dc_mp.disconnect_reason = 'Network timeout');

-- Proof, this should be empty
--
WITH subquery_result AS
   (SELECT participation_id
    FROM match_participants
    WHERE match_id IN
          (SELECT DISTINCT match_id
           FROM match_participants
           WHERE disconnect_reason = 'Network timeout')),
     cte_result AS
   (WITH dc_match_id AS
       (SELECT DISTINCT match_id
        FROM match_participants
        WHERE disconnect_reason = 'Network timeout') SELECT mp.participation_id
    FROM match_participants AS mp
    WHERE mp.match_id IN
          (SELECT match_id
           FROM dc_match_id)),
     exists_result AS
   (SELECT mp.participation_id
    FROM match_participants AS mp
    WHERE EXISTS
          (SELECT 1
           FROM match_participants AS dc_mp
           WHERE dc_mp.match_id = mp.match_id
              AND dc_mp.disconnect_reason = 'Network timeout'))
SELECT participation_id,
       subq.participation_id IS NOT NULL AS sub_query,
                                            cte.participation_id IS NOT NULL AS cte_query,
                                                                                ex.participation_id IS NOT NULL AS ex_query
FROM subquery_result AS subq
FULL OUTER JOIN cte_result AS cte USING (participation_id)
FULL OUTER JOIN exists_result AS ex USING (participation_id)
WHERE subq.participation_id IS NULL
   OR cte.participation_id IS NULL
   OR ex.participation_id IS NULL;