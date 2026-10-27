-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Case Study: ApexPetro Energy Limited
--
-- Transaction Reversal Using ROLLBACK
-- ============================================================

-- Scenario:
-- Work Order 9 is currently Open.
-- Lubrication Oil stock is currently 100 units.
--
-- The transaction will temporarily:
-- 1. Reduce Lubrication Oil stock by five units.
-- 2. Record an inventory issue.
-- 3. Change Work Order 9 to Completed.
-- 4. Reverse all changes using ROLLBACK.


-- ============================================================
-- BEFORE-TRANSACTION VERIFICATION
-- ============================================================

SELECT
    'BEFORE TRANSACTION' AS verification_stage,
    work_order_id,
    description,
    scheduled_date,
    status
FROM work_order
WHERE work_order_id = 9;


SELECT
    'BEFORE TRANSACTION' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 3;


-- Confirm that no matching test inventory issue exists.

SELECT
    COUNT(*) AS matching_test_transactions_before
FROM inventory_transaction
WHERE spare_part_id = 3
  AND transaction_date = DATE '2026-10-09'
  AND transaction_type = 'Issue'
  AND quantity = 5;


-- ============================================================
-- START TRANSACTION
-- ============================================================

BEGIN;


-- Temporarily reduce Lubrication Oil stock from 100 to 95.

UPDATE spare_part
SET quantity_in_stock = quantity_in_stock - 5
WHERE spare_part_id = 3
  AND quantity_in_stock >= 5;


-- Temporarily record an inventory issue.

INSERT INTO inventory_transaction (
    spare_part_id,
    transaction_date,
    transaction_type,
    quantity
)
VALUES (
    3,
    '2026-10-09',
    'Issue',
    5
);


-- Temporarily change Work Order 9 to Completed.

UPDATE work_order
SET status = 'Completed'
WHERE work_order_id = 9;


-- ============================================================
-- INSIDE-TRANSACTION VERIFICATION
-- These results show the temporary uncommitted changes.
-- ============================================================

SELECT
    'INSIDE TRANSACTION' AS verification_stage,
    work_order_id,
    description,
    scheduled_date,
    status
FROM work_order
WHERE work_order_id = 9;


SELECT
    'INSIDE TRANSACTION' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 3;


SELECT
    'INSIDE TRANSACTION' AS verification_stage,
    transaction_id,
    spare_part_id,
    transaction_date,
    transaction_type,
    quantity
FROM inventory_transaction
WHERE spare_part_id = 3
  AND transaction_date = DATE '2026-10-09'
  AND transaction_type = 'Issue'
  AND quantity = 5;


-- ============================================================
-- REVERSE ALL UNCOMMITTED CHANGES
-- ============================================================

ROLLBACK;


-- ============================================================
-- AFTER-ROLLBACK VERIFICATION
-- ============================================================

-- Work Order 9 should return to Open.

SELECT
    'AFTER ROLLBACK' AS verification_stage,
    work_order_id,
    description,
    scheduled_date,
    status
FROM work_order
WHERE work_order_id = 9;


-- Lubrication Oil stock should return to 100.

SELECT
    'AFTER ROLLBACK' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 3;


-- The temporary inventory issue should no longer exist.

SELECT
    COUNT(*) AS matching_test_transactions_after_rollback
FROM inventory_transaction
WHERE spare_part_id = 3
  AND transaction_date = DATE '2026-10-09'
  AND transaction_type = 'Issue'
  AND quantity = 5;
