# Portfolio 5: Distributed and Cloud Database
## Overview
Portfolio 5 examines distributed and cloud database concepts using the fictional ApexPetro Energy Limited Operations & Maintenance Management System developed throughout the MIT 8103 portfolio.

The scenario considers how database services could support multiple fictional operational locations:

Alpha Processing Facility

Bravo Flow Station

Delta Storage Terminal

Echo Production Facility

The portfolio addresses database replication, availability, data distribution, sharding considerations, consistency, monitoring, backup and cloud database deployment.

All organisations, locations, records and architectural scenarios used in this portfolio are fictional and created solely for academic purposes.

## Portfolio 5 Activities Completed
This portfolio demonstrates:

1. Development of a proposed distributed and cloud database architecture.

2. Analysis of database replication and availability.

3. Analysis of data distribution and sharding considerations.

4. Analysis of consistency requirements for different categories of ApexPetro data.

5. Practical use of a cloud-hosted MongoDB Atlas database.

6. Review of cloud database monitoring information.

7. Technical analysis and reflection.

### 1. Distributed and Cloud Database Architecture
A distributed and cloud database architecture was developed for the fictional ApexPetro environment.

The proposed architecture connects the four operational locations to application services supporting:

maintenance-management applications;

web and mobile applications;

API services;

authentication and authorisation; and

controlled database access.

The application layer connects to two logical database services:

**Relational Database Service**

The relational database supports structured transactional information including:

assets;

equipment;

employees;

work orders;

maintenance activities;

spare parts;

inventory transactions;

vendors; and

maintenance costs.

**Document Database Service**

The document database supports:

equipment inspections;

condition-monitoring measurements;

observations; and

recommendations.

The proposed cloud infrastructure includes primary and replica database nodes together with backup, monitoring, security and administrative services.

See:

architecture/distributed-cloud-architecture.md

Architecture diagram:

architecture/apexpetro-distributed-cloud-architecture.png

## 2. Replication and Availability
Replication was analysed as a mechanism for reducing dependence on a single database node.

The proposed architecture considers:

a primary database node;

replica database nodes;

redundancy;

database availability;

node-failure considerations;

monitoring; and

backup and recovery.

Replication and backup were treated as separate controls.

Replication supports active database redundancy and availability, while backup provides a separate recovery capability for scenarios such as accidental deletion, corruption or other data-loss events.

See:

analysis/replication-availability.md

## 3. Data Distribution and Sharding
Sharding was analysed as a possible mechanism for horizontally distributing database data and workload.

For academic illustration, the four ApexPetro operational locations were considered as possible logical distribution boundaries:

Alpha Processing Facility;

Bravo Flow Station;

Delta Storage Terminal; and

Echo Production Facility.

However, operational location was not presented as a proven production shard key.

Actual shard-key selection would require consideration of:

data volume;

query patterns;

write distribution;

hotspot risk;

cross-location access; and

future growth.

See:

analysis/sharding-distribution.md

## 4. Data Consistency
Consistency requirements were considered according to the nature and business importance of the information being processed.

Stronger transactional consistency is particularly relevant to:

work-order status;

spare-part quantities;

inventory issues;

inventory receipts;

maintenance transactions; and

related operational updates.

The consistency analysis builds on the transaction-management principles demonstrated in Portfolio 3, including:

COMMIT;

ROLLBACK;

transaction isolation; and

row-level concurrency control.

Inspection and condition-monitoring documents have different structural and access characteristics, but controlled updates and consistent identifiers remain important.

See:

analysis/consistency-analysis.md

## 5. Cloud Database Deployment
A practical cloud database component was implemented using MongoDB Atlas.

The cloud-hosted implementation contains:

the ApexPetroCluster deployment;

the apexpetro_nosql database; and

the equipment_inspections collection.

The cloud-hosted collection contains the synthetic equipment inspection documents developed in Portfolio 4.

The MongoDB Atlas deployment interface displayed a cluster topology containing one primary and two secondary members.

No deliberate node-failure or failover test was performed as part of this portfolio.

## 6. Cloud Database Monitoring
MongoDB Atlas monitoring was used to view deployment metrics for ApexPetroCluster.

The monitoring interface provided operational information for the cluster members and displayed available database metrics such as:

operation counters;

connections;

logical size;

network activity;

operation throttling; and

sorting activity.

This provided practical evidence that the cloud-hosted database environment could be monitored through the Atlas interface.

## 7. Supporting Evidence
The evidence folder contains practical and architectural evidence supporting Portfolio 5.

The evidence includes:

The proposed distributed and cloud architecture.

The MongoDB Atlas ApexPetroCluster deployment.

The cloud-hosted ApexPetro database and collection.

The equipment inspection documents stored in the cloud collection.

The MongoDB Atlas monitoring view.

See:

evidence/README.md

## Implemented Versus Proposed Components

It is important to distinguish the database components that were practically implemented from those analysed as part of the proposed architecture.

**Practically Implemented**

The portfolio provides practical evidence of:

a cloud-hosted MongoDB Atlas deployment;

the apexpetro_nosql database;

the equipment_inspections collection;

eight synthetic inspection documents hosted in the cloud database;

the Atlas deployment interface displaying primary and secondary cluster members; and

cloud database monitoring.

**Proposed or Analysed**

The following elements are architectural proposals or analytical exercises rather than claims of practical implementation:

location-based sharding;

distributed relational database deployment;

deliberate primary-node failure testing;

automated failover testing;

multi-region deployment;

cross-shard transaction testing; and

production workload benchmarking.

This distinction ensures that the portfolio's technical conclusions remain supported by the evidence produced.

## Technical Reflection
The main objective of Portfolio 5 was to understand how the database solutions developed in the earlier portfolio activities could operate within a wider distributed and cloud database environment.

The architecture exercise demonstrated that database distribution involves more than placing data in the cloud. Replication, availability, data distribution, consistency, monitoring, backup, security and recovery need to be considered together.

A major learning point was the distinction between replication and sharding. Replication maintains additional copies of data to support redundancy and availability, while sharding distributes portions of data and workload across database nodes. Although operational location provided an intuitive example for the fictional ApexPetro distribution scenario, the exercise demonstrated that a shard key should not be selected solely because it appears logically convenient. Query patterns, data volume, write distribution and hotspot risk must also be considered.

The consistency analysis also reinforced the connection between distributed database architecture and the transaction controls demonstrated in Portfolio 3. Operational information such as stock quantities, inventory movements and work-order status requires careful transaction and consistency management even when the underlying database infrastructure is distributed.

The practical MongoDB Atlas implementation was particularly useful because it provided direct experience of a cloud-hosted database environment. The ApexPetro NoSQL database and equipment inspection collection were hosted within Atlas, and the deployment interface displayed one primary and two secondary cluster members. The monitoring interface also provided visibility into database operational metrics.

An important limitation of the practical exercise was that no deliberate cluster-member failure, sharding implementation, multi-region deployment or cross-shard transaction test was performed. These elements were therefore treated as architectural analysis rather than represented as practical results.

This activity improved my understanding of cloud database deployment, replication, high availability, sharding, consistency, monitoring, backup and the importance of distinguishing between proposed distributed architecture and components that have actually been implemented and tested.

## Summary
Portfolio 5 extends the ApexPetro case study into a distributed and cloud database context.

The portfolio demonstrates:

development of a distributed/cloud database architecture;

replication and availability analysis;

data-distribution and sharding analysis;

data-consistency analysis;

genuine deployment of the ApexPetro document database in MongoDB Atlas;

practical cloud-database monitoring; and

objective documentation of implementation limitations.

The portfolio therefore combines practical cloud database evidence with distributed database architecture and analysis while maintaining consistency with the ApexPetro case study used throughout MIT 8103.
