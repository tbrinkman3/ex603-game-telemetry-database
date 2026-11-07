# Memo

## Matches Not Started

Matches 14 and 15 were set to active but never had a player participate.  This indicates a match initiatiation problem.  In the match creation process there is an existing error that allows matches to be started and considered valid with no player participation.

The relevant teams should analyze the match creation process to determine the edge case where matches are created and active without any players joining.  It is either a gap in business logic and matches need to be considered inactive after a certain threshold of no players joining or the scenario where a match can start with no member needs to be disallowed.


