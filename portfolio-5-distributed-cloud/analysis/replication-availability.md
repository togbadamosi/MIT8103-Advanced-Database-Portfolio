# Portfolio 5: Distributed and Cloud Database
## Replication and Availability Analysis
### 1. Overview
The proposed ApexPetro distributed and cloud database architecture uses database replication as a mechanism for improving redundancy and availability.

Replication involves maintaining copies of database data across multiple database nodes so that database services are not dependent on only one node.

The architecture presented in this portfolio is a proposed academic design for the fictional ApexPetro Energy Limited scenario.

### 2. Proposed Replication Architecture
The proposed cloud database architecture contains:

a primary database node;

one or more replica database nodes;

database monitoring;

backup and recovery services; and

controlled access through application services.

The primary node represents the database node responsible for normal read/write processing in the simplified architecture.

Replica nodes maintain additional copies of the database information according to the replication capabilities and configuration of the selected database platform.

### 3. Purpose of Replication
Replication is proposed to support the following objectives:

1. Database redundancy.

2. Improved service availability.

3. Reduction of dependency on a single database node.

4. Support for recovery from individual node failure.

5. Maintenance of additional copies of operational data.

Without replication, failure of a single database server could make the database service unavailable until the failed system is restored or replaced.

### 4. Primary and Replica Nodes
The architecture diagram represents one logical primary node and multiple logical replica nodes.

The primary node processes database changes and the replicated nodes maintain copies of the relevant database information.

The exact replication behaviour depends on the selected database platform and deployment configuration.

The architecture therefore represents the replication concept rather than claiming that a production replication configuration has been implemented.

### 5. Availability
Availability refers to the ability of authorised users and applications to access database services when required.

For the fictional ApexPetro scenario, database availability is relevant because users at:

Alpha Processing Facility;

Bravo Flow Station;

Delta Storage Terminal; and

Echo Production Facility

may need access to operational and maintenance information.

The proposed architecture reduces reliance on a single database node by including replicated database nodes.

### 6. Node Failure Scenario
Consider a scenario where the current primary database node becomes unavailable.

In an appropriately configured replicated database environment, another eligible and healthy node may assume the required database role according to the capabilities and configuration of the selected technology.

The purpose of this design is to reduce the impact of an individual database-node failure.

The portfolio does not claim that an actual multi-node failover test has been performed.

### 7. Replication and Data Consistency
Replication introduces an important consistency consideration.

Database changes made through the active write service must be propagated to the relevant replicas according to the consistency and durability settings of the database platform.

For critical ApexPetro transactional data such as:

spare-part quantities;

inventory issues and receipts;

work-order status;

maintenance transactions; and

related operational updates,

the database configuration should reflect the importance of accurate and durable writes.

The required consistency settings should therefore be based on the business importance of the data and the capabilities of the selected database technology.

### 8. Replication Versus Backup
Replication and backup serve different purposes.

**Replication**
Replication provides additional copies of active database data and supports redundancy and availability.

**Backup**
Backup provides a separate recovery mechanism for events such as:

accidental deletion;

unwanted data changes;

data corruption; and

other data-loss scenarios.

A replicated error may be propagated to replicas. Replication should therefore not be treated as a replacement for backup.

The proposed ApexPetro architecture includes both replication and backup/recovery considerations.

### 9. Monitoring and Health
Replication should be supported by database monitoring.

Monitoring should consider:

database-node availability;

replication health;

database performance;

storage utilisation;

connection activity;

alerts; and

backup status.

Monitoring helps administrators identify database availability or replication issues requiring investigation.

### 10. Network Considerations
A distributed database architecture depends on reliable communication between users, applications and database services.

Potential network considerations include:

connectivity between operational locations and cloud services;

network interruption;

latency;

secure connections; and

bandwidth requirements.

The effect of these factors depends on actual deployment conditions and is therefore not measured in this academic architecture.

### 11. Relational and Document Database Services
The ApexPetro architecture contains both relational and document-oriented database services.

The relational service supports structured transactional information such as:

work orders;

spare parts;

inventory transactions;

maintenance activities; and

related master data.

The document database supports:

inspection records;

condition-monitoring measurements;

observations; and

recommendations.

Replication strategies for the two database technologies would depend on the replication capabilities and configuration of each selected platform.

### 12. Architectural Limitation
The Portfolio 5 architecture demonstrates the principles of replication and high availability.

The portfolio does not claim that:

a production multi-node relational database cluster has been deployed;

actual primary-node failure has been initiated;

automated failover has been tested;

multi-region replication has been implemented; or

specific recovery-time or recovery-point targets have been measured.

These would require an appropriately configured production or laboratory database environment.

### 13. Conclusion
Replication is an important component of the proposed ApexPetro distributed and cloud database architecture because it reduces reliance on a single database node and supports database redundancy and availability.

However, replication works together with other controls, including monitoring, backup, recovery, access control and transaction management.

The proposed architecture therefore combines replication, backup and monitoring considerations rather than treating replication as a complete availability solution on its own.
