# Portfolio 1: Database Design and Modelling
## Normalisation
The ApexPetro Energy Limited Operations & Maintenance Management System was designed using relational database normalisation principles to reduce data redundancy, improve data integrity and ensure that data dependencies are appropriately represented.

The database design was normalised through First Normal Form (1NF), Second Normal Form (2NF) and Third Normal Form (3NF).

## 1. First Normal Form (1NF)

A relation is in First Normal Form when each column contains atomic values, repeating groups are removed, and each record can be uniquely identified.

The ApexPetro database satisfies 1NF because:

Each table has a primary key that uniquely identifies each record.
Each column stores a single value rather than multiple values.
Repeating groups have been separated into appropriate tables.
Multiple maintenance activities, inspections, failures and inventory transactions are stored as individual records rather than as repeating columns.
For example, equipment details are stored in the equipment table, while the multiple maintenance activities relating to equipment are recorded separately through work_order and maintenance_activity.

Similarly, an equipment item may undergo several inspections over time. Instead of creating columns such as inspection_1, inspection_2 and inspection_3 within the equipment table, each inspection is stored as an individual record in the inspection table.

Therefore, the database satisfies 1NF.

## 2. Second Normal Form (2NF)

A relation is in Second Normal Form when it is already in 1NF and every non-key attribute depends on the whole primary key rather than only part of a composite key.

Most ApexPetro tables use a single-column primary key. Examples include:

asset_id in asset

equipment_id in equipment

employee_id in employee

work_order_id in work_order

activity_id in maintenance_activity

inspection_id in inspection

failure_id in equipment_failure

spare_part_id in spare_part

transaction_id in inventory_transaction

vendor_id in vendor

The associative tables require particular consideration because they use composite primary keys.

## Maintenance Part
The maintenance_part table uses the composite primary key:

(activity_id, spare_part_id)

The non-key attribute quantity_used relates to the combination of a particular maintenance activity and a particular spare part.

A quantity used cannot meaningfully be determined from activity_id alone or spare_part_id alone because the value represents the quantity of that specific spare part used in that specific maintenance activity.

## Vendor Spare Part
The vendor_spare_part table uses the composite primary key:

(vendor_id, spare_part_id)

The combination represents the relationship between a specific vendor and a specific spare part. Vendor information is maintained in the vendor table, while spare-part information is maintained in the spare_part table.

This avoids storing vendor or spare-part descriptive information repeatedly in the associative table.

Therefore, the database satisfies 2NF.

## 3. Third Normal Form (3NF)
A relation is in Third Normal Form when it is already in 2NF and non-key attributes depend on the primary key rather than on other non-key attributes.

The ApexPetro design separates information into entities according to the subject represented by each table.

For example:

Asset information is stored in the asset table.

Equipment information is stored in the equipment table.

Employee information is stored in the employee table.

Vendor information is stored in the vendor table.

Spare-part information is stored in the spare_part table.

Work-order information is stored in the work_order table.

Maintenance activity information is stored in the maintenance_activity table.

Inspection information is stored in the inspection table.

Equipment failure information is stored in the equipment_failure table.

The equipment table stores asset_id as a foreign key instead of repeating asset details such as asset name, asset type and location for every equipment record.

Similarly, the work_order table stores equipment_id and employee_id as foreign keys rather than duplicating equipment and employee descriptive information.

The maintenance_activity table stores work_order_id rather than repeating work-order details.

The inventory_transaction table stores spare_part_id rather than repeating spare-part name, part number and unit cost for every inventory transaction.

These separations reduce duplication and ensure that descriptive information is maintained in the table representing the relevant entity.

Therefore, the database satisfies 3NF.

## Normalisation Summary
The ApexPetro relational database has been designed to satisfy 1NF, 2NF and 3NF.

**1NF** is achieved by storing atomic values, eliminating repeating groups and uniquely identifying records.

**2NF** is achieved by ensuring that non-key attributes depend on the complete primary key, including within the associative tables.

**3NF** is achieved by separating entity-specific information so that non-key attributes depend on the relevant table's primary key rather than other non-key attributes.

The resulting structure reduces unnecessary data duplication and supports consistent relationships between assets, equipment, employees, work orders, maintenance activities, inspections, failures, spare parts, inventory transactions and vendors.
