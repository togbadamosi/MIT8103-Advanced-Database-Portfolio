# Portfolio 1: Database Design and Modelling
## Case Study
This portfolio activity presents the database design and modelling for the ApexPetro Energy Limited Operations & Maintenance Management System.

ApexPetro Energy Limited is a fictional oil and gas company created solely for this academic portfolio. The database supports the management of assets, equipment, employees, work orders, maintenance activities, inspections, equipment failures, spare parts, inventory transactions and vendors.

All data used in the case study is synthetic and created for academic purposes.

## Portfolio 1 Deliverables
**1. Case Study Description**

The case study describes the organisation, nature of the system, database users, major data to be stored and key database operations.

See: case-study.md

**2. Business Rules**

The business rules define the operational requirements, relationships and data integrity requirements used in designing the database.

See: business-rules.md

**3. Entity Relationship Diagram**

The ER diagram presents the database entities, attributes, primary keys, foreign keys and relationships used in the ApexPetro database design.

See: er-diagram.md

**4. Relational Schema, Keys and Constraints**

The relational database schema implements the database design using PostgreSQL-compatible SQL.

The schema includes:

Primary keys
Foreign keys
Composite keys
NOT NULL constraints
UNIQUE constraints
CHECK constraints
Referential integrity rules
See: sql/schema.sql

**5. Normalisation**

The database design was evaluated against First Normal Form (1NF), Second Normal Form (2NF) and Third Normal Form (3NF).

See: normalisation.md

## Database Implementation and Testing
The relational schema was executed in a PostgreSQL environment and the creation of the 12 database tables was verified.

Controlled tests were also performed to demonstrate:

Successful insertion of valid data.
Enforcement of foreign-key relationships.
Enforcement of unique equipment serial numbers.
Rejection of negative spare-part stock quantities.
Enforcement of permitted work-order status values.
Supporting screenshots are available in the evidence/ folder.

## Portfolio 1 Evidence
The evidence folder contains screenshots supporting the implementation and testing of the relational database schema.

Evidence includes:

Schema and table verification
Valid asset insertion
Foreign-key constraint test
Unique serial-number constraint test
Negative-stock CHECK constraint test
Work-order status CHECK constraint test
## Summary
Portfolio 1 establishes the relational database foundation for the ApexPetro Energy Limited Operations & Maintenance Management System. The resulting database design provides structured relationships between operational assets, equipment, maintenance processes, inspections, failures, spare parts, inventory transactions, employees and vendors.

The database model and SQL implementation provide the foundation for the subsequent query processing, transaction management, NoSQL and distributed/cloud database activities in the MIT 8103 portfolio.
