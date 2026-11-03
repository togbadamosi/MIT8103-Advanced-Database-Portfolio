# Portfolio 5: Distributed and Cloud Database
## Data Consistency Analysis
### 1. Overview
A distributed database environment must consider how database information remains accurate and consistent when data is stored, replicated or accessed across multiple database nodes.

For the fictional ApexPetro Energy Limited scenario, consistency requirements depend on the nature and business importance of the information being processed.

The proposed architecture therefore distinguishes between transaction-critical operational data and more flexible inspection and condition-monitoring information.

### 2. Transaction-Critical Data
Certain ApexPetro records require a high level of transactional consistency because inconsistencies could affect operational processing.

Examples include:

work-order status;

spare-part stock quantities;

inventory receipts;

inventory issues;

maintenance transactions; and

related operational updates.

For example, issuing a spare part should not reduce the recorded stock quantity without also recording the corresponding inventory transaction.

These related database changes should therefore be treated as coordinated units of work.

### 3. Relationship with Portfolio 3
Portfolio 3 demonstrated transaction-management controls including:

COMMIT;

ROLLBACK;

REPEATABLE READ; and

SELECT ... FOR UPDATE.

These controls remain relevant in the proposed distributed architecture.

**COMMIT**

COMMIT permanently saves a successful transaction after the required database operations have been completed.

**ROLLBACK**

ROLLBACK reverses uncommitted changes when a transaction should not be completed.

**Transaction Isolation**

Transaction isolation controls how database changes are viewed during transaction processing.

**Row-Level Locking**

SELECT ... FOR UPDATE can be used to select and lock a database row before a controlled update.

These controls help maintain consistency within transactional database operations.

### 4. Consistency and Replication
Replication maintains additional copies of database information.

When data is replicated, changes made through the active database service must be propagated to the relevant replica nodes according to the selected database technology and configuration.

This creates a consistency consideration because different database platforms may provide different controls over:

write acknowledgement;

replica synchronisation;

read behaviour; and

failover.

For critical ApexPetro transactional records, consistency and durability requirements should be considered when configuring the replicated database service.

### 5. Stronger Consistency Requirements
Stronger consistency requirements are appropriate where users and applications need confidence that they are working with the latest successfully committed transactional information.

Examples include:

**Spare-Part Inventory**

Users issuing spare parts should not make decisions using an incorrect stock quantity.

**Inventory Transactions**

An inventory issue or receipt should remain consistent with the related stock movement.

**Work-Order Status**

The work-order status should accurately reflect whether maintenance work remains open, is in progress, is completed or has been cancelled.

**Related Maintenance Transactions**

Records that form part of the same business transaction should remain logically consistent with each other.

### 6. Inspection and Condition-Monitoring Information
The document-oriented inspection model developed in Portfolio 4 has different structural characteristics.

Inspection documents contain:

equipment information;

asset information;

inspector information;

condition-monitoring measurements;

observations; and

recommendations.

These documents are generally represented as self-contained inspection records.

The consistency configuration for this type of information should still protect data integrity, but its access and update patterns may differ from stock and transaction processing.

### 7. Embedded Document Consistency
One advantage of the Portfolio 4 document model is that related inspection information is stored within one inspection document.

For example, one inspection document may contain:

equipment details;

measurement values;

observations; and

recommendations.

An update to that document can modify related inspection information without requiring changes across several relational tables.

However, embedded descriptive information may become outdated if corresponding master information changes elsewhere.

For example, an asset name embedded in an old inspection document may intentionally represent the information as recorded at the time of inspection, or it may require an application rule governing synchronisation.

This behaviour should therefore be defined according to business requirements.

### 8. Consistency and Sharding
If data is distributed across shards, consistency requirements remain important.

Operations involving records located within one shard may be simpler than transactions requiring information distributed across multiple shards.

The database design should therefore consider:

transaction boundaries;

shard-key selection;

cross-shard queries;

cross-shard updates; and

enterprise-wide reporting.

The exact behaviour depends on the capabilities and configuration of the selected database technology.

### 9. Consistency and Availability Trade-Offs
Distributed database architectures may require design decisions concerning consistency, availability and network conditions.

For the ApexPetro scenario, these decisions should be driven by the business importance of individual data categories.

For example:

inventory quantities should prioritise transactional accuracy;

work-order completion should remain consistent with related maintenance records;

inspection reporting may have different read and analytical requirements.

The portfolio does not prescribe one consistency configuration for every category of ApexPetro data.

### 10. Failure and Recovery Considerations
Database consistency must also be considered during failure and recovery.

Relevant scenarios include:

database-node failure;

network interruption;

interrupted transactions;

replica recovery;

backup restoration; and

application failure during transaction processing.

The transaction-management mechanisms demonstrated in Portfolio 3 help address interrupted or incomplete transactions at database level.

Replication, backup and recovery mechanisms address different aspects of distributed availability and data protection.

### 11. Validation and Monitoring
Consistency should not depend solely on database architecture.

Additional controls may include:

database constraints;

transaction validation;

application validation;

monitoring;

reconciliation;

exception reporting; and

audit logging.

These controls can help identify incomplete, invalid or unexpected database activity.

### 12. Proposed ApexPetro Consistency Approach
For the academic ApexPetro architecture, the proposed approach is:

**Transactional Relational Data**

Prioritise accurate and durable processing for:

work orders;

maintenance transactions;

spare-part quantities;

inventory movements; and

related transactional records.

**Inspection Documents**

Use the document database to support flexible inspection structures while maintaining controlled document updates and consistent identifiers.

**Replicated Data**

Configure replication and acknowledgement according to the importance of the data and the capabilities of the selected database technology.

**Distributed Data**

Select distribution strategies only after considering transaction boundaries, query patterns and cross-location access requirements.

### 13. Architecture Limitation
The consistency discussion represents an academic architecture and analysis.

The portfolio does not claim that:

distributed relational transactions have been implemented;
replica consistency has been benchmarked;
network-partition behaviour has been experimentally measured;
cross-shard transactions have been tested; or
one consistency configuration has been proven optimal for production use.
These areas would require a suitable multi-node testing environment and defined business service requirements.

### 14. Conclusion
Consistency is a critical consideration within the proposed ApexPetro distributed and cloud database architecture.

The required level of consistency depends on the business importance and access pattern of the data.

Transactional records such as stock quantities, inventory movements and work-order status require careful transaction control, while document-oriented inspection records support more flexible structures and access patterns.

The principles demonstrated across Portfolios 1 to 4 therefore remain relevant when the same database services are considered within a distributed and cloud environment.
