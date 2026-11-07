--Write a query that joins three tables to display the actor who performed each event, the producer associated with the event, and the event's date and time.

SELECT p.player_name,
       mp.match_id,
       m.scheduled_on
FROM players p
JOIN match_participants mp ON p.player_id = mp.player_id
JOIN matches m on mp.match_id = m.match_id;

--Write a query that connects the producer table to the catalog table through the junction table. Return the producers associated with your theme's catalog tag.

SELECT gm.mode_name,
       mm.match_id
FROM matches m
JOIN match_modes mm ON m.match_id = mm.match_id
JOIN game_modes gm ON mm.mode_id = gm.mode_id;

--Write a self join to compare records within the producer table. Use the results to explore whether the producers identified in Assignment 4 share characteristics with other producers or whether differences in activity levels may explain their performance.

SELECT a.match_code,
       b.match_code,
       a.player_count
FROM matches a
JOIN matches b ON a.player_count = b.player_count
AND a.match_id < b.match_id;