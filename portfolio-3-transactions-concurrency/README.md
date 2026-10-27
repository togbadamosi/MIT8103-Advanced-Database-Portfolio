# Portfolio 3: Transactions and Concurrency
## Overview
Portfolio 3 applies transaction-management, transaction-isolation and concurrency-control techniques to the ApexPetro Energy Limited Operations & Maintenance Management System.

The practical activities build on the relational database developed in Portfolio 1 and the synthetic records created in Portfolio 2.

All organisations, records and transaction scenarios used in this portfolio are fictional and were created solely for academic purposes.

Portfolio 3 Deliverables
This portfolio demonstrates:

1. A successful multi-step transaction using COMMIT.
2. Reversal of uncommitted database changes using ROLLBACK.
3. Transaction isolation using REPEATABLE READ.
4. A concurrency-control mechanism using SELECT ... FOR UPDATE.
5. Practical execution and output evidence.
6. Technical analysis and reflection.

## 1. Successful Transaction Using COMMIT
A multi-step transaction was developed to complete Work Order 7 and record its related maintenance and inventory activities.

Before the transaction:

Work Order 7 had a status of Open.
Oil Filter stock was 30 units.
The transaction:

Inserted a maintenance activity.
Linked one Oil Filter to the maintenance activity.
Reduced Oil Filter stock by one unit.
Recorded an inventory Issue transaction.
Changed Work Order 7 to Completed.
Permanently saved the related changes using COMMIT.
After the transaction:

Work Order 7 had a status of Completed.
Oil Filter stock had reduced from 30 to 29.
The maintenance activity, spare-part usage and inventory Issue transaction remained in the database.
See: sql/commit-transaction.sql

## 2. Transaction Reversal Using ROLLBACK
A separate transaction was used to demonstrate the reversal of uncommitted database changes.

Before the transaction:

Work Order 9 had a status of Open.
Lubrication Oil stock was 100 units.
No matching test inventory Issue transaction existed.
Inside the transaction:

Work Order 9 was temporarily changed to Completed.
Lubrication Oil stock was temporarily reduced from 100 to 95.
An inventory Issue transaction for five units was temporarily inserted.
The transaction was then reversed using ROLLBACK.

After the rollback:

Work Order 9 returned to Open.
Lubrication Oil stock returned to 100.
The temporary inventory Issue transaction no longer existed.
See: sql/rollback-transaction.sql

## 3. Transaction Isolation
The transaction-isolation exercise used the PostgreSQL REPEATABLE READ isolation level.

The transaction explicitly executed:

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

## 4. Concurrency-Control Mechanism

The concurrency-control exercise used a Pump Bearing stock-issue scenario.

Before the transaction:

Pump Bearing stock was 15 units.

The target spare-part row was selected using:

SELECT ...
FROM spare_part
WHERE spare_part_id = 5
FOR UPDATE;

The transaction then:

Selected the Pump Bearing record using FOR UPDATE.
Reduced the stock by one unit.
Recorded an inventory Issue transaction.
Saved the controlled changes using COMMIT.

After the transaction:

Pump Bearing stock reduced from 15 to 14.
An inventory Issue transaction for one unit was successfully recorded.

See: sql/concurrency-control.sql

## 5. Testing Limitation

The transaction-isolation and row-locking demonstrations were executed in a single-session online PostgreSQL environment.

The isolation test therefore demonstrates:

successful selection of the REPEATABLE READ isolation level;
confirmation of the active isolation level; and
repeated reads within the same transaction.

The concurrency-control test demonstrates:

implementation of SELECT ... FOR UPDATE;
selection of the relevant row for update;
controlled stock reduction;
inventory-transaction recording; and
successful transaction completion.

The evidence does not claim that a second concurrent database session attempted to modify the locked record or was observed waiting for the lock.

A full two-session blocking demonstration would require two independent sessions connected to the same persistent PostgreSQL database.

## 6. Transaction and Concurrency Analysis

The detailed analysis explains:

the business scenarios used;
the transaction boundaries;
the effects of COMMIT;
the effects of ROLLBACK;
the configured isolation level;
the row-locking mechanism;
the test results; and
the limitations of the single-session testing environment.

See: analysis/transaction-concurrency-analysis.md

## 7. Supporting Evidence

The evidence folder contains screenshots showing:

The successful COMMIT transaction.
Verification of the committed maintenance and inventory changes.
The original and temporary states during the ROLLBACK test.
Restoration of the original state after ROLLBACK.
Selection and verification of the REPEATABLE READ isolation level.
Execution of the SELECT ... FOR UPDATE row-locking mechanism.

See: evidence/README.md

## Technical Reflection

The main objective of this portfolio activity was to understand how related database operations can be processed as logical units of work rather than as independent SQL statements.

The successful COMMIT transaction demonstrated that completing a maintenance process may require several connected database changes. These changes included recording a maintenance activity, linking a spare part to that activity, updating stock, recording an inventory issue and changing the work-order status. Grouping the changes inside one transaction ensured that the related operations could be permanently saved together.

The ROLLBACK exercise demonstrated the importance of transaction atomicity. Although the work-order status, stock quantity and inventory records were changed temporarily, executing ROLLBACK restored the original work-order status and stock quantity and removed the temporary inventory transaction. This showed how a database can prevent incomplete or unwanted changes from remaining after an unsuccessful business process.

The isolation exercise improved my understanding of how a transaction's view of data can be controlled. The REPEATABLE READ level was explicitly selected and verified before the same spare-part record was read twice within the transaction.

The concurrency-control exercise demonstrated the use of SELECT ... FOR UPDATE to select and lock a row before changing stock. This approach is relevant where multiple maintenance or inventory users could attempt to issue the same spare part at approximately the same time.

A key limitation was that the online PostgreSQL environment provided a single execution session. It was therefore possible to implement and execute the isolation and row-locking controls, but not to observe a second concurrent session waiting for a locked record. This limitation was documented rather than presenting the single-session test as a complete two-session concurrency simulation.

This activity strengthened my understanding of transaction boundaries, atomic processing, durability, rollback behaviour, transaction-isolation levels and row-level locking. It also reinforced the importance of matching technical claims to the evidence actually produced during testing.

## Summary

Portfolio 3 demonstrates the practical application of transaction-management and concurrency-control concepts to the ApexPetro relational database.

The portfolio provides evidence of:

permanent transaction processing using COMMIT;
transaction reversal using ROLLBACK;
transaction isolation using REPEATABLE READ;
row-level concurrency control using SELECT ... FOR UPDATE;
verification of database states before, during and after transactions; and
objective documentation of the testing environment's limitations.

These exercises demonstrate how transaction controls help maintain the consistency and integrity of operational, maintenance and inventory information.
