-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Case Study: ApexPetro Energy Limited
--
-- Concurrency Control Using SELECT FOR UPDATE
-- ============================================================

-- Scenario:
-- Two maintenance users could attempt to issue the same
-- spare part at approximately the same time.
--
-- Without appropriate control, both transactions might read
-- the same stock quantity before either update is completed.
--
-- SELECT FOR UPDATE locks the selected spare-part row for the
-- duration of the transaction.


-- ============================================================
-- BEFORE-TRANSACTION VERIFICATION
-- ============================================================

SELECT
    'BEFORE LOCK' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 5;


-- ============================================================
-- START TRANSACTION
-- ============================================================

BEGIN;


-- ============================================================
-- LOCK THE TARGET SPARE-PART ROW
-- ============================================================

SELECT
    'ROW LOCKED FOR UPDATE' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 5
FOR UPDATE;


-- ============================================================
-- ISSUE ONE UNIT ONLY IF SUFFICIENT STOCK EXISTS
-- ============================================================

UPDATE spare_part
SET quantity_in_stock = quantity_in_stock - 1
WHERE spare_part_id = 5
  AND quantity_in_stock >= 1;


-- Record the controlled stock issue.

INSERT INTO inventory_transaction (
    spare_part_id,
    transaction_date,
    transaction_type,
    quantity
)
VALUES (
    5,
    '2026-10-10',
    'Issue',
    1
);


-- ============================================================
-- SAVE THE CONTROLLED TRANSACTION
-- ============================================================

COMMIT;


-- ============================================================
-- AFTER-COMMIT VERIFICATION
-- ============================================================

SELECT
    'AFTER CONTROLLED ISSUE' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 5;


SELECT
    transaction_id,
    spare_part_id,
    transaction_date,
    transaction_type,
    quantity
FROM inventory_transaction
WHERE spare_part_id = 5
  AND transaction_date = DATE '2026-10-10'
  AND transaction_type = 'Issue'
ORDER BY transaction_id;
