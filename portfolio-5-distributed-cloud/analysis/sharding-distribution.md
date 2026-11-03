# Portfolio 5: Distributed and Cloud Database
## Sharding and Data Distribution Analysis
### 1. Overview
As the volume of ApexPetro operational and maintenance data grows, a distributed database architecture may need to spread data and workload across multiple database nodes.

Sharding is considered in this portfolio as a possible horizontal data-distribution technique.

The discussion is based on the fictional ApexPetro Energy Limited scenario and represents a proposed architectural design rather than an implemented production sharding environment.

### 2. Concept of Sharding
Sharding distributes records across multiple database partitions or nodes rather than storing the complete dataset on one database node.

Each partition is referred to as a shard.

A shard key determines how individual records are assigned to the available shards.

The purpose of sharding is different from replication.

Replication maintains additional copies of data.

Sharding distributes portions of data across multiple database nodes.

A distributed architecture may use both techniques where appropriate.

### 3. ApexPetro Distribution Scenario
The fictional ApexPetro environment contains four operational locations:

Alpha Processing Facility

Bravo Flow Station

Delta Storage Terminal

Echo Production Facility

Operational and maintenance records are associated with assets and equipment located at these facilities.

A possible data-distribution approach could therefore use an operational-location or asset identifier as part of the distribution strategy.

### 4. Illustrative Location-Based Distribution
For academic illustration, data could be logically distributed as follows:

**Shard A**

Records associated primarily with:

Alpha Processing Facility

**Shard B**

Records associated primarily with:

Bravo Flow Station

**Shard C**

Records associated primarily with:

Delta Storage Terminal

**Shard D**

Records associated primarily with:

Echo Production Facility

This structure provides an intuitive example because much of the operational data is associated with identifiable facilities and assets.

However, this does not demonstrate that operational location would necessarily be the best production shard key.

### 5. Potential Data Distributed by Location
Examples of data that may have a location relationship include:

equipment records;

work orders;

maintenance activities;

inspections;

condition-monitoring records;

equipment failures; and

selected inventory records.

For example, an inspection document already includes an embedded asset identifier and location information.

A distribution strategy could potentially use these attributes to determine data placement.

### 6. Shard-Key Considerations
The selection of a shard key is an important design decision.

A suitable shard key should be evaluated against actual access patterns and data characteristics.

Relevant considerations include:

how evenly records would be distributed;

expected write volumes;

common query filters;

data growth;

the frequency of cross-location queries;

hotspot risk; and

whether individual locations generate significantly different data volumes.

A poor shard key can result in uneven workload distribution.

### 7. Risk of Uneven Distribution
A location-based distribution strategy may appear logical but could become unbalanced.

For example, one operational facility may eventually contain significantly more:

equipment;

work orders;

inspections; or

maintenance records

than another location.

If this occurs, one shard could receive substantially more data and workload than the others.

Therefore, the current four-location example should be treated as an illustrative data-distribution design rather than proof of balanced production sharding.

### 8. Query Considerations
Sharding can affect query execution.

A query targeting a specific shard-key value may potentially be directed towards the relevant portion of distributed data.

In contrast, a query that requires records across multiple locations may need to access multiple shards and combine results.

Examples of potential cross-location queries include:

total maintenance cost across all facilities;

failure frequency across all equipment;

enterprise-wide overdue work orders;

inspection-condition summaries across all operational locations; and

organisation-wide spare-part analysis.

The database-distribution design should therefore consider both local and enterprise-wide query requirements.

### 9. Relationship with the Relational Database
A distributed relational database would require careful consideration because transactions may involve records that are not naturally isolated by operational location.

Examples include:

central vendor information;

employee master data;

shared spare-part information;

enterprise reporting; and

transactions involving centrally managed data.

The relational database should therefore not be partitioned solely on the basis of the illustrative architecture without analysing actual workload and transaction requirements.

### 10. Relationship with the Document Database
The ApexPetro NoSQL inspection documents already contain attributes such as:

equipment.equipment_id;

equipment.equipment_type;

asset.asset_id;

asset.asset_name; and

asset.location.

These fields provide possible candidates for evaluating data-distribution strategies.

However, the final shard key would still require analysis of:

document volume;

frequently executed queries;

write patterns; and

expected data growth.

### 11. Replication and Sharding
Replication and sharding solve different architectural problems.

**Replication**

Supports:

redundancy;

additional copies of data;

availability; and

resilience against individual-node failure.

**Sharding**

Supports:

horizontal data distribution;

workload distribution; and

scaling beyond a single database node.

A distributed database may combine sharding and replication so that individual shards also have redundant copies.

The exact implementation depends on the chosen database technology.

### 12. Central Reporting
ApexPetro would still require enterprise-wide reporting even if operational data were distributed.

Examples include:

overall maintenance expenditure;

equipment-failure trends;

enterprise work-order status;

inspection-condition analysis; and

inventory reporting.

The distributed architecture must therefore support consolidated queries without assuming that each location operates as a completely isolated database environment.

### 13. Distribution Limitation
This portfolio does not claim that sharding has been implemented in the ApexPetro environment.

The Portfolio 5 sharding component demonstrates:

the concept of horizontal data distribution;

a location-based distribution example;

possible shard-key considerations;

risks of uneven data distribution;

cross-shard query considerations; and

the relationship between replication and sharding.

Actual sharding implementation would require a suitable distributed database environment and workload analysis.

### 14. Conclusion
Sharding provides a mechanism for distributing data and workload across multiple database nodes.

For the fictional ApexPetro scenario, operational location provides an understandable example of how data could be distributed across Alpha Processing Facility, Bravo Flow Station, Delta Storage Terminal and Echo Production Facility.

However, operational location should not automatically be selected as the production shard key.

Actual shard-key selection should consider data volume, query patterns, write distribution, cross-location access and the risk of uneven workload distribution.

The Portfolio 5 architecture therefore treats location-based sharding as an illustrative design rather than a proven production configuration.
