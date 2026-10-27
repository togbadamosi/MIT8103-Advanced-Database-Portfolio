# Portfolio 3: Transactions and Concurrency
## Transaction and Concurrency Analysis
### 1. Overview
This activity demonstrates transaction management and concurrency-control techniques using the ApexPetro Energy Limited Operations & Maintenance Management System.

The practical tests covered:

1. Successful transaction processing using COMMIT.
2. Reversal of uncommitted changes using ROLLBACK.
3. Transaction isolation using REPEATABLE READ.
4. Row-level concurrency control using SELECT FOR UPDATE.
The demonstrations were performed against the relational database developed in Portfolio 1 and the synthetic dataset created in Portfolio 2.

### 2. Successful Transaction Using COMMIT
### Scenario
A multi-step transaction was used to complete Work Order 7 and record the associated maintenance and spare-part activity.

Before the transaction:

Work Order 7 had a status of Open.
Oil Filter stock was 30 units.
The transaction:

Inserted a maintenance activity.
Linked one Oil Filter to the maintenance activity.
Reduced Oil Filter stock by one unit.
Recorded an inventory Issue transaction.
Changed Work Order 7 to Completed.
Executed COMMIT.
### Result
After COMMIT:

Work Order 7 had a status of Completed.
Oil Filter stock reduced from 30 to 29.
The maintenance activity remained in the database.
The spare-part usage record remained in the database.
The inventory Issue transaction remained in the database.
### Interpretation
The test demonstrates transaction durability and the use of COMMIT to make related database changes permanent.

The maintenance process involved several dependent operations. Processing these operations within one transaction helps ensure that the related changes are handled as one logical unit of work.

### 3. Transaction Reversal Using ROLLBACK
### Scenario
A separate transaction was used to demonstrate reversal of uncommitted changes involving Work Order 9 and Lubrication Oil.

Before the transaction:

Work Order 9 had a status of Open.
Lubrication Oil stock was 100 units.
No matching test inventory Issue transaction existed.
Inside the transaction:

Work Order 9 was temporarily changed to Completed.
Lubrication Oil stock was temporarily reduced from 100 to 95.
A temporary inventory Issue transaction for five units was inserted.
The transaction was then terminated using ROLLBACK.

### Result
After ROLLBACK:

Work Order 9 returned to Open.
Lubrication Oil stock returned to 100.
The temporary inventory Issue transaction no longer existed.
Interpretation
The ROLLBACK test demonstrates that uncommitted changes can be reversed as a group.

This is important where several related database operations form a single business process. If the process cannot be completed successfully, partial changes should not remain and create inconsistencies between work-order and inventory information.

### 4. Transaction Isolation
### Scenario
A transaction was started using the PostgreSQL REPEATABLE READ isolation level.

The test used the Pump Mechanical Seal record.

Before the transaction:

Spare Part ID: 1
Part Number: PMS-001
Unit Cost: 120000.00
Stock Quantity: 20
The transaction explicitly executed:

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

The active isolation level was verified using:

SHOW transaction_isolation;

### Result
The database returned:

repeatable read

The Pump Mechanical Seal record was then read twice within the same transaction.

Both the first and second reads returned the same values, including a stock quantity of 20.

The transaction was subsequently completed using COMMIT.

### Interpretation
The test confirms that REPEATABLE READ was successfully selected and used for the transaction.

Repeatable Read is designed to prevent non-repeatable reads within a transaction by maintaining a consistent transactional view of the relevant data.

Testing Limitation
The online PostgreSQL environment used for the portfolio provided a single execution session for this practical demonstration.

Therefore, the test verifies:

successful selection of the REPEATABLE READ isolation level;
verification of the active isolation level; and
repeated reads within the same transaction.
The test does not claim that a second concurrent session changed the record between the first and second reads.

A genuine two-session isolation test would require two database sessions connected to the same persistent database.

### 5. Concurrency-Control Mechanism
### Scenario
A spare-part stock issue was used to demonstrate a concurrency-control mechanism.

The target record was:

Spare Part ID: 5
Part Name: Pump Bearing
Part Number: PBR-001
Initial Stock: 15 units
A potential concurrency risk exists where two maintenance transactions attempt to issue the same spare part at approximately the same time.

The transaction used:

SELECT ... FOR UPDATE

to select the Pump Bearing record before its stock quantity was changed.

### Result
The execution output showed:

the original stock quantity of 15;
successful transaction start;
the row selected using FOR UPDATE;
one successful stock update;
one inventory Issue transaction;
successful COMMIT; and
a final stock quantity of 14.
The inventory Issue transaction recorded a quantity of one.

### Interpretation
The SELECT ... FOR UPDATE statement provides a row-level locking mechanism before the selected record is modified.

This approach helps control concurrent modification of the same stock record by requiring a transaction to lock the relevant row before making the controlled change.

The stock update also included a condition requiring sufficient available stock before the quantity could be reduced.

### Testing Limitation
The practical test was performed in a single-session online PostgreSQL environment.

Therefore, the evidence demonstrates that the row-locking statement was implemented and executed as the concurrency-control mechanism.

The evidence does not claim that a second concurrent session attempted to modify the row or was observed waiting for the first transaction to release the lock.

A full blocking demonstration would require two independent sessions connected to the same persistent database.

### 6. Transaction-Control Summary
The Portfolio 3 exercises demonstrate four related database-control concepts:

COMMIT permanently saved a successful multi-step maintenance transaction.
ROLLBACK reversed multiple uncommitted database changes.
REPEATABLE READ demonstrated explicit transaction-isolation configuration.
SELECT ... FOR UPDATE demonstrated row-level locking as a concurrency-control mechanism.
Together, these controls help protect the consistency and integrity of operational and maintenance information where multiple database operations form part of the same business process.

### 7. Conclusion
The Portfolio 3 exercises demonstrate that transaction management involves more than executing individual SQL statements.

Related database operations should be managed as logical units of work so that successful transactions can be committed while unsuccessful or unwanted changes can be rolled back.

Transaction isolation provides control over how data is viewed during transaction processing, while row-level locking can help manage the risk of concurrent updates to shared records.

The practical exercises improved understanding of transaction boundaries, atomic processing, rollback behaviour, transaction isolation and row-level concurrency control within a relational database environment.
