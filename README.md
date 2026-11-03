# MIT 8103: Advanced Database Systems
## Continuous Assessment Portfolio Summary
## Student Name: Taofeek Gbadamosi
## Student ID: 301887647
## Programme: Master of Information Technology
## Course: MIT 8103 Advanced Database Systems
## Case Study: ApexPetro Energy Limited
## GitHub Repository: https://github.com/togbadamosi/MIT8103-Advanced-Database-Portfolio
### 1. Case Study Overview
ApexPetro Energy Limited is an imaginary Oil & Gas company used solely for this academic portfolio. The portfolio builds up an Operations & Maintenance Management System for assets, equipments, employees, work orders, maintenance activities, inspections, equipment failures, spare-parts stock, vendors and related operational records.

The same case study was used for all five portfolio activities. This gave them a stable foundation for demonstrating relational database design and processing SQL queries, transaction management and implementation of NoSQL and distributed/cloud databases. The portfolio includes fictional and synthetic elements of all organisations, locations, operational records and datasets.
### 2. Portfolio 1: Database Design and Modelling
The ApexPetro system was designed to be based on a relational database, which was built using the relational technology of Portfolio 1. The work covered a description of the case-study, business rules, Entity Relationship Diagram, relational schema, keys, database constraints and normalisation analysis.

The schema includes classes for assets, equipment, employees, work orders, maintenance activities, inspections, equipment failures, spare parts, inventory transactions and vendors. To overcome the many to many relationships of maintenance activities with spares, and vendors with spares, associative tables were added.

Primary key, foreign key, composite key, NOT NULL, UNIQUE and CHECK constraints have been added. The design was checked with First, Second and Third Normal Forms. The 12 database tables were created during execution and valid data was inserted during controlled tests, including foreign-key, unique and check constraints.
### 3. Portfolio 2: Query Processing and Optimisation
In portfolio 2, synthetic operational data was added to the relational database and SQL queries were designed to answer realistic maintenance-management questions.

The questions included outstanding work orders, equipment maintenance history, maintenance cost per asset, equipment failure rate, spare-parts usage, overdue work orders, employee work order responsibility and maintenance performance by equipment.

In the initial asset-maintenance summary, there was a one-to-many relationship in the test scenario, resulting in row duplication.In the test scenario, there was also a one-to-many join so the initial asset-maintenance summary over-estimated the amount of maintenance. The query was corrected by adding up the different sets of data first, and then adding up the summaries.

The performance of queries was measured with EXPLAIN (ANALYZE, BUFFERS). An overdue-work-order query was created with a partial index. The work-order table was small and the query returned a large percentage of its data, so PostgreSQL kept a sequential scan. The test showed that it is not always possible to compile an index which will result in the compilation of an 'index scan'.
### 4. Portfolio 3: Transactions and Concurrency
Transaction Management, Isolation and Concurrency control were shown in Portfolio 3.

Maintenance activity, spares usage, inventory issue and work-order completion were logged into the system in one transaction using a multi-step maintenance transaction, with COMMIT used to record the completion of the work-order. The separate test reversed temporary work-order status, stock quantity and stock inventory changes using ROLLBACK.

The REPEATABLE READ isolation level was specifically set and tested. To control row-level concurrency, the following statement was used: SELECT ... FOR UPDATE before the stock of spareparts was updated.

A single execution session was available in the on-line PostgreSQL environment. The evidence shows configuration of the isolation level and implementation of the row-locking mechanism, but not that a second concurrent transaction was observed waiting for the lock.
### 5. Portfolio 4: NoSQL and Advanced Data Models
Portfolio 4 utilized an ApexPetro document-oriented NoSQL model for equipment inspections and condition monitoring data.

There are eight synthetic inspection documents in MongoDB Atlas. Embedded objects represented equipment, assets, inspectors and equipment-specific measurements. Multiple observations and recommendations stored in arrays.

The flexible structure allowed for storing different measurement fields in the pumps, compressors, separators and generators without having to use the same attributes in each document.
The queries are run on embedded asset, equipment and measurement fields. The existing inspection document was supplemented with an additional recommendation and aggregation operations summarised inspections by condition and equipment type. The exercise illustrated how a document database can be used to support flexible and nested data in conjunction with the relational database.
### 6. Portfolio 5: Distributed and Cloud Database
In Portfolio 5, the ApexPetro case study was expanded to a distributed and cloud database environment.

The architecture proposed was based on the following fictional operational locations, relational and document database services, replication, availability, data distribution, sharding, consistency, monitoring, backup and security.

Redundancy and availability were considered through the analysis of replication. The idea of sharding was floated for distributing data and workload. Operational location was selected as a distribution example but was not offered as a production shard key.
MongoDB Atlas was utilized in the practical cloud part. The following databases and collections were deployed in the cloud: apexpetro_nosql, equipment_inspections. The Atlas interface showed one primary cluster member and two secondary cluster members and the monitoring interface showed deployment metrics.
No intentional node failure or failover, multi-region or cross-shard transaction test was performed. The elements were analysed as architectural elements and not as practically realised results.
Technical Reflection

The portfolio showcased how database needs change from structured relational transactions to flexible document data and distributed/cloud environments.

One of the key points was that logical correctness or performance improvement is not guaranteed by successful execution. The query results were aggregated in the Portfolio 2 aggregation problem, and the results had to be reconciled to find duplicate maintenance costs. As for the optimisation exercise, the same was true as above and an index should be considered based on the actual execution plan and not assumed to be an improvement on performance.

The transaction exercises strengthened the concept of atomicity, rollback, isolation and row-level locking when it comes to operational record protection. The NoSQL exercise illustrated the ability of embedded documents, arrays, and adaptable measurement structure to be used for equipment inspections. The cloud activity illustrated how each of these architectural requirements (replication, sharding, consistency, availability, monitoring and backup) are satisfied.
Overall, the assessment reinforced my practical knowledge on relational modelling, SQL implementation, query validation, optimisation, transaction management, document databases and distributed/cloud database architecture.
## AI Use Declaration
This portfolio was created with the use of Microsoft 365 Copilot, a learning, drafting and technical assistance tool.

The interpretation of the assessment requirements, organisation of the GitHub repository, refinement of the fictional ApexPetro case study, development and troubleshooting of SQL and NoSQL examples, design of controlled tests, and improvement of written explanations were all helped by AI assistance.
The suggestions generated by AI were not accepted due to the fact that they were executed successfully, but rather were checked against the selected case study. Database schemas, SQL queries, transaction tests and NoSQL operations were virtually performed and verified. The results of the queries were checked, errors that were found were corrected, and screen shots of the actual results of implementation were kept.

I analyzed the database design, Business Rules, ER model, relational schema, SQL queries, normalisation, transaction tests and the NoSQL model, as well as the distributed/cloud architecture and the supporting evidence. I accept responsibility for the accuracy, originality, understanding and explanation of the work submitted.

## Repository and Evidence
The complete technical portfolio is available at:

https://github.com/togbadamosi/MIT8103-Advanced-Database-Portfolio

The repository includes 5 folders of the portfolio, SQL and NoSQL scripts, technical analyses, architecture documentation, README and practical screenshots.
Prior to submission, the repository will be made available to the assessor.

## References

•	MIT 8103 Advanced Database Systems assessment brief and course materials.

•	MongoDB, Inc. MongoDB Database Manual: Document Modelling, CRUD Operations and Aggregation.

•	MongoDB, Inc. MongoDB Atlas Documentation: Cloud Deployment, Data Explorer and Monitoring.

•	PostgreSQL Global Development Group. PostgreSQL Documentation: Constraints, Transactions, Concurrency Control and EXPLAIN.
