## MATCH_PARTICIPANTS.player_id
### Source
**PLAYERS.player_id**

### ON DELETE
**RESTRICT**

If a player's row is removed from the MATCH_PARTICIPANTS table on account delete, it will corrupt any aggregation metrics and historical analysis.  If the player participated in a match in the past, this should remain recorded as it occurred.

## MATCH_PARTICIPANTS.match_id
### Source
**MATCHES.match_id**

### ON DELETE
**CASCADE**

If a match is being deleted, it shoudl be removed from the record table as it is being intentonally being removed from the history.  Once the match is removed, all records about its participation should be removed as well.

## MATCH_MODES.match_id
### Source
**MATCHES.match_id**

### ON DELETE
**CASCADE**

If a match is deleted, any record of its mode should be removed as well.

## MATCH_MODES.game_id
### Source
**GAMES_MODES.game_id**

### ON DELETE
**RESTRICT**
If a game mode is referenced to an existing match, then the record should remain, as the deletion would remove games that occured with a specified match type.