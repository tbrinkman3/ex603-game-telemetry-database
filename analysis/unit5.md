# Part 1
## What feature or report on your platform could use the three-table join from Question 1? What information would it display?

The three table join could would be used to display a match history dashboard.  It would display matches, when they occurred and what players participated in those matches.


## Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?

There is a many to many relationship between the matches and their games modes.  A match can have multiple game modes.  The junction table allows this relationship to be represented and queried against.  If the many relationship was represented in a single column, it would be difficult to extract the relationship between the matches with multiple game modes.

# Part 2

## Which producers were excluded by the inner join? Report their identifiers.

Matches 14 and 15 were excluded by the inner join, their identifiers were a missing match id from the match participants table.

## What does it mean when a producer has no events? What are some possible explanations?

When a producer does not have any events, it could mean that the match was started and everyone disconnected before it started.  This could be due to code errors, network errors, or corrupted data.

## How could a report based only on an inner join give leadership an incomplete picture of the platform?

The inner join omitting rows would not give an accurate representation across aggregate counts.  Any aggregatings across tables would include the null rows and potentially corrupt averages and means.

## Why might leadership want to identify producers who have never been active?

Inactive producers can expose design issues or areas for potential growth.  Active matches with not participants indicate dropped matches which would impact user experience and could lead to declines in participation if the user experience is so poor.

## What action could leadership take based on these findings?

Leadership would use the data to identify customer experience issue and present issues to techincal teams to address.

## Distinguish between what your data shows and what would require further investigation.

The data shows that match participants do not have a match id attached to them.  Further investigation would be required to identify how participants could join an active match yet not be assigned.  Either the match was inaccuratley marked as active or there is an issue with match registration.

# Part 3
## Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.
A Cartesion would be usefule when querying against existing matches that have occured and finding which match mode and game modes have not occurred yet.  The CROSS JOIN table would serve as the baseline to query against.
## Which join algorithms did PostgreSQL choose for your query?
PostgreSQL selected a Nested Loop and a Hash Join
## What information in the execution plan helps explain those choices?
There was a hash condition on the player id against the tables and a smaller row count that allowed a loop to be efficient.
## Why is it useful to understand the selected join algorithms?
Knowing the underlying conditions for how the query is executed can allow for further optimization, creation of new indexes (or the decision to not create additioanl indexes)
## What changes to the data or database might make another join algorithm more appropriate?
As the data grows, the nested loop could be abandoned for the hash join as the hashes are more efficient on larger data sets.