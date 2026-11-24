= Similar articles and theses

== Gorilla

The in-memory TSDB developed by Facebook (Meta) for real-time system health and performance monitoring. 
The database acts as a fast write-through cache for recent monitoring metrics before persisting older 
data to long-term storage like HBase @pelkonen2015gorilla.

The database uses XOR floating-point encoding and delta-of-delta encoding which allows 
to store data in memory. This reduces query latency by 73x and improves query throughput 
by 14x when compared to a traditional database (HBase)-backed time series data.
Gorilla incorporates a new time series compression algorithm that allows to compress 
each by series down from 16 bytes to an average of 1.37 bytes, a 12x reduction in size.

The difference in systems lays in the fact that while Gorilla's persistent storage is external and network-based, 
our implementation will use purely embedded design - the in-memory layer acting as a write-through cache
and persistent local disk storage.

== 