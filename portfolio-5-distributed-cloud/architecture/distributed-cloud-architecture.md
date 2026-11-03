# Portfolio 5: Distributed and Cloud Database
## Distributed and Cloud Database Architecture
### 1. Scenario
ApexPetro Energy Limited is a fictional oil and gas company used throughout the MIT 8103 portfolio.

For this portfolio activity, ApexPetro is assumed to operate from four fictional operational locations:

Alpha Processing Facility
Bravo Flow Station
Delta Storage Terminal
Echo Production Facility

A central cloud database environment is proposed to support database availability, shared access and consolidation of operational information across these locations.

All locations, systems and architectural arrangements described in this portfolio are fictional and created solely for academic purposes.

### 2. Architecture Objectives
The proposed architecture is intended to support the following database requirements:

Centralised access to operational and maintenance information.
Database availability if an individual database node becomes unavailable.
Distribution of database workload where appropriate.
Replication of database information between database nodes.
Consistent processing of critical operational transactions.
Support for structured relational records and flexible inspection documents.
Cloud-based access for geographically separated operational locations.
### 3. Proposed Architecture
The proposed design contains three logical layers:

1. Operational Locations

2. Application and Database Services

3. Cloud Database Infrastructure

**Operational Locations**

The fictional ApexPetro operational locations are:

Alpha Processing Facility

Bravo Flow Station

Delta Storage Terminal

Echo Production Facility

Users at these locations generate and retrieve information relating to:

equipment;

work orders;

maintenance activities;

inspections;

equipment failures;

spare parts; and

inventory transactions.

### 4. Application and Database Services
Two main database services are represented in the architecture.

**Relational Database Service**
The relational database service supports structured transactional information including:

assets;

equipment;

employees;

work orders;

maintenance activities;

spare parts;

inventory transactions;

vendors; and

maintenance costs.

The relational data model developed in Portfolio 1 remains the basis for this service.

Transaction-management and concurrency controls demonstrated in Portfolio 3 remain relevant to this component.

**Document Database Service**

The document database service supports:

equipment inspections;

condition-monitoring measurements;

observations; and

recommendations.

This component builds on the document-oriented NoSQL model implemented in Portfolio 4.

The document database supports flexible measurement structures for different equipment types.

### 5. Cloud Database Layer
The proposed cloud layer contains multiple logical database nodes rather than relying on a single database server.

The architecture includes:

a primary database node;

replicated secondary database nodes;

distributed data storage where appropriate; and

monitoring and backup services.

This arrangement is intended to reduce dependence on a single database node.

### 6. Replication
Replication involves maintaining copies of database data across multiple database nodes.

In the proposed ApexPetro architecture, replication would support:

redundancy;

improved database availability;

recovery from individual node failure; and

maintenance of additional copies of operational data.

For critical transactional information, the architecture should ensure that database writes are completed according to the consistency and durability requirements of the selected database platform.

Replication does not remove the need for backups.

Replicas support availability, while backup copies provide separate recovery capability for scenarios such as accidental deletion, corruption or other data-loss events.

### 7. Availability
The architecture is designed to avoid reliance on a single database node.

If one replicated database node becomes unavailable, another healthy replica may support continued database service according to the capabilities and configuration of the selected database technology.

Availability considerations include:

redundant database nodes;

health monitoring;

controlled failover;

backup and recovery;

network connectivity; and

operational monitoring.

The precise failover behaviour depends on the database platform and deployment configuration.

### 8. Data Distribution and Sharding
As the volume of ApexPetro operational information grows, the database workload may be distributed across multiple database nodes.

A possible logical distribution key is operational location.

For example, data could potentially be partitioned using identifiers representing:

Alpha Processing Facility;

Bravo Flow Station;

Delta Storage Terminal; and

Echo Production Facility.

However, operational location should not automatically be selected as a production sharding key.

Before selecting a shard key, the organisation would need to consider:

query patterns;

data volumes;

write distribution;

risk of uneven data distribution;

cross-location queries; and

future growth.

The portfolio therefore presents location-based distribution as an architectural example rather than claiming that it has been proven to be the optimal production shard key.

### 9. Consistency Requirements
Different categories of ApexPetro information may have different consistency requirements.

**Stronger Consistency Requirements**

Information requiring strict transactional accuracy includes:

work-order status;

spare-part stock quantities;

inventory issues and receipts;

maintenance transactions; and

other related operational updates.

For example, spare-part stock should not be reduced independently of the inventory transaction that records the issue.

**Flexible Read Requirements**

Certain inspection and condition-monitoring information may support different read patterns because:

inspection documents are often retrieved independently;

records may contain flexible measurement structures; and

analysis may take place across multiple inspection documents.

The appropriate consistency configuration should therefore be selected according to the business importance of the data and the database technology being used.

### 10. Relationship with Transaction Management
The distributed architecture does not eliminate the need for transaction controls.

The transaction-management principles demonstrated in Portfolio 3 remain relevant, including:

COMMIT;

ROLLBACK;

isolation levels; and

concurrency control.

Distributed deployment introduces additional considerations because database operations may involve replicated or distributed infrastructure.

Application design must therefore consider both transaction integrity and distributed-system behaviour.

### 11. Cloud Monitoring
A cloud deployment should include monitoring of database health and performance.

Relevant monitoring areas include:

database availability;

node health;

query performance;

storage utilisation;

connection activity;

replication health;

backup status; and

database alerts.

Monitoring information can support the early identification of operational and capacity issues.

### 12. Backup and Recovery
Replication and backup serve different purposes.

Replication supports database redundancy and availability.

Backup supports recovery from events such as:

accidental deletion;

data corruption;

incorrect application changes; and

other data-loss scenarios.

The proposed architecture therefore includes both replication and backup/recovery considerations.

### 13. Security Considerations
A distributed cloud database architecture should also consider:

authenticated database access;

role-based permissions;

encrypted connections;

protection of database credentials;

controlled network access;

audit logging; and

monitoring of administrative activity.

The detailed implementation of these controls would depend on the selected database and cloud platform.

### 14. Proposed Logical Data Flow
The proposed logical flow is:

Operational Locations ↓ Application Services ↓ Relational and Document Database Services ↓ Cloud Database Infrastructure ↓ Replication / Distribution / Backup / Monitoring

Operational users access application services rather than directly modifying individual replicated database nodes.

The database layer is responsible for storing, retrieving and protecting the ApexPetro operational information.

### 15. Architecture Scope and Limitation
This architecture is a proposed academic design for the fictional ApexPetro scenario.

The portfolio does not claim that:

production infrastructure has been deployed;

multi-region failover has been tested;

relational database sharding has been implemented;

a specific cloud provider is mandatory; or

the proposed location-based distribution method has been proven optimal.

Where practical deployment evidence is included later in Portfolio 5, it will be clearly distinguished from proposed architectural components.

### 16. Architecture Summary
The proposed ApexPetro distributed and cloud database architecture combines:

geographically separated operational locations;

application services;

relational database services;

document-oriented database services;

replicated database nodes;

possible data distribution;

availability controls;

consistency considerations;

monitoring; and

backup and recovery.

The design demonstrates how the database work developed in Portfolios 1 to 4 can be considered within a broader distributed and cloud database environment.
