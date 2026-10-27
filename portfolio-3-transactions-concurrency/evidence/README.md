# Portfolio 3 Evidence
This folder contains practical screenshots supporting the transaction-management and concurrency-control demonstrations for the ApexPetro database.

## Evidence Index
00-commit-transaction-execution.png - Shows the original transaction state, execution of the multi-step transaction and COMMIT.

01-commit-after-verification.png - Confirms the committed work-order, stock, maintenance and inventory changes.

02-rollback-before-and-inside.png - Shows the original database state and temporary changes made inside the transaction.

03-rollback-after-verification.png - Confirms that ROLLBACK restored the original values and removed the temporary inventory transaction.

04-repeatable-read-isolation.png - Confirms that REPEATABLE READ was selected and shows repeated reads within the transaction.

05-row-lock-concurrency-control.png - Shows the SELECT FOR UPDATE row-lock mechanism, controlled stock issue and committed result.

## Testing Note
The isolation and row-lock demonstrations were executed in a single-session online PostgreSQL environment.

The evidence therefore demonstrates the implemented isolation level and row-locking control mechanism but does not claim that a second concurrent session was observed modifying or waiting for the same database record.
