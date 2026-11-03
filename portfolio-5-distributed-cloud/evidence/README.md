# Portfolio 5 Evidence
This folder contains supporting evidence for the distributed and cloud database component of the ApexPetro Energy Limited case study.

The evidence distinguishes between:

The proposed distributed database architecture.

The cloud database environment actually implemented.

Distributed concepts analysed but not practically deployed.

## Evidence Index
00-distributed-cloud-architecture.png - Shows the proposed ApexPetro distributed and cloud database architecture, including operational locations, application services, database services, replicated nodes, backup, monitoring and security.

01-mongodb-atlas-cluster.png - Shows the cloud-hosted ApexPetro MongoDB Atlas cluster used for the practical implementation.

02-cloud-database-collection.png - Shows the cloud-hosted apexpetro_nosql database and equipment_inspections collection in MongoDB Atlas.

03-cloud-database-documents.png - Shows the inspection documents stored in the cloud-hosted collection.

04-cloud-monitoring-view.png - Shows the available MongoDB Atlas monitoring or deployment-health view, where accessible.

## Scope of Evidence
The MongoDB Atlas screenshots provide genuine evidence that the ApexPetro document database was hosted and accessed through a cloud database platform.

The architecture diagram provides evidence of the proposed wider distributed design.

The evidence does not claim that:

relational database sharding was implemented;

multi-region replication was configured;

automated failover was tested;

replica-node failure was simulated;

cross-shard transactions were tested; or

the academic architecture was deployed as a production environment.

Replication, sharding, availability and consistency are therefore addressed through the architecture and analysis files, while the MongoDB Atlas screenshots provide evidence of the cloud database component actually implemented.
