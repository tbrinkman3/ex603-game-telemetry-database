# Unit 4 Analysis

The data shows that most matches included disconnected participants.  Overall, this indicates that most matches have distruption and inconsistency in the user experience.  Further investigation would be to investigate if this was contained to a specific region to detmine what could be contributing to player disruption.

There was not a clear correlation of number of match participants to the disconnection rate. Matches 9,5,3, and 11 would need to be investigated as they have the highest disconnection rate.  The participants in these matches woudl likely have the worst user experience.

---

## Reflection

Where possible, conditional aggregation is preferred becuase of its efficiency at processing data.  At production levels of data, every full pass over the data base is expensive.  Two filtered queries would be double the execution time.  At the rate that the queries are run, reducing execution times of milliseconds can quickly add up and make a meaningful difference to the user experince.

There is also sublte danger when using two passes because during development, the datasets will likely be a manageable size to be reasoned about, and therefore performance issues with the queries will go unnoticed in testing.  The error would not appear until the production dataset reaches a large enoguh size to expose the bottleneck, and by that point, creating a solution has to potential to be challenging.

