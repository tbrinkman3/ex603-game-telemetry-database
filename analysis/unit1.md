# Unit 1

## Modelling Justification

All primary keys are generate by the DB on row creation. Assuming Postgres, native v7 UUID generation will be utilized.  This decision was made to support a future state of a distributed system, where the v7 UUID still supports performant indexes as the number of players and matches grows.  To remain consisent across the tables, v7 UUID is also used in the `GAME_MODES` table.

`PLAYERS.player_name` uniqueness will be enforced by the application as well as the database.  Players will be allowed to change their player name so the `player_name` cannot be used as the primary key.  The `player_name` is constrained to 16 characters, conforming to industry standards to facilitate uniform UI decisions, that do not need to accomodate to wrapping text or verbose names.

The `timestampz` value is used across all tables for unified time representation.  Players will be joining from many timezones, the application will handle the user's locale and rendering the appropriate times zones.  Consistent time representation in across the tables will simplify query creation.

### On Delete Behaviors

`MATCH_PARTICIPANTS.match_id` and `MATCH_MODES.match_id` are both set to `ON DELETE CASCADE`.  If a match is deleted, all participant and match mode records should be remove as the match is being permanently remvoed from the records.  Not removing would leave orphaned rows, corrupting aggregate and historical queries.

`MATCH_PARTICIPANTS.player_id` is set to `ON DELETE RESTRICT`.  If a player has participated in a match, FK reference cannot be remove as it would create null references.  The fact that a player participated in a match should be a historical, immutable record.  An enhancement to the current schema would be to add an additioanl `delete` column to indicate if a player account has been removed.  This would allow queries to exclude deleted players while maintaining match records.

`MATCH_MODES.game_id` is set to `ON DELETE RESTRICT`.  A match that occurred with a specific game mode should still have this recorded, as it is the historical record.  Similar to player, an additional column to indicate a game mode that is no longer active would allow for the deletion as well as maintaining accurate FK references.


## Reflection

A decision that could be open for rework would be the `NOT NULL` requirement on the `MATCH_PARTICIPANTS.player_score`.  This is requiring a score to be present for the player when the record is created.

This decision was made because every player should enter the game with a score, `0` being a default for a player entering a match.  This will force the application layer to supply.

An argument could be made for allowing a null to indicate that a player has entered the match, but has not yet started participating. Currently, it would be hard to differentiate between players who joined a match, but failed to participate, from players who joined a match, and scored zero.