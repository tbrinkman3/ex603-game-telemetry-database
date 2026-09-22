# Unit 2

## Constraints Table

| Foreign Key                                           | ON DELETE Choice | Reason                                                                      |
| ----------------------------------------------------- | ---------------- | --------------------------------------------------------------------------- |
| `match_modes.match_id` -> `matches.match_id`          | CASCADE          | If the match is removed, references should be removed.                      |
| `match_modes.game_id` -> `game_modes.game_id`         | RESTRICT         | A match that occurs with a specific game mode, should retain the game mode. |
| `match_participants.player_id` -> `players.player_id` | RESTRICT         | A player's participation in a match should be permanent.                    |
| `match_participants.match_id` -> `matches.match_id`   | CASCADE          | A match being removed should remove all records of its participants.        |

---

**CASCADE on `match_modes.match_id`:** The match association in this table exists to link the match to a specific game mode.  If the match is deleted, then the records no longer needs to exists.  If left undeleted, any table joins could results in null values on non-existent match ids.  This delete decisions prevents this scenario.

**RESTRICT on `match_modes.game_id`:** Restricting the deletion of the game id preserves the historical integrity of the matches.  A game that occurred of a specific game mode, will always have been a game of that mode.  If the mode is deleted, it will corrupt historical records of the matches.

**RESTRICT on `match_participants.player_id`:** Similar to the restriction of the game id, the player id must also be maintained to preserve data integrity.  A player's participation in a match must be historically preserved.  Null references in the players table will lead to inaccurate metrics and player rankings.

**CASCADE on `match_participants.match_id`:** Contrary to the player id, if the decision is made to delete a match, the all records of the participants should be removed.  If a game is considered invalid and shoudl not count towards players' history, then all records of the participants for that match should be removed.

## CHECK Constraints

### chk_player_name_no_whitespace
This is intended to be an additional guard, in combination with the application layer, to ensure that player don't consume the availabe character count intentionally or unintentionally.  This will preserve player name display across the program.

### chk_max_players_positive
This prevents a scenario where the max players could be set to a negative number, effectively rendering the match unjoinable.

### chk_player_score_positive
This prevents a negative score ever being recorded against a player.  The application layer will be the major enforcer, but the check at the database level ensure that any application errors are not able to corrupt the data.
