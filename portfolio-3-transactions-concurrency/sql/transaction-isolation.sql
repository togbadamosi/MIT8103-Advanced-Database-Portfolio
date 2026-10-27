-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Case Study: ApexPetro Energy Limited
--
-- Transaction Isolation Demonstration
-- ============================================================

-- Scenario:
-- This transaction demonstrates PostgreSQL's REPEATABLE READ
-- isolation level using the Pump Mechanical Seal record.
--
-- Under REPEATABLE READ, the transaction operates using a
-- consistent database snapshot for its duration.


-- ============================================================
-- ORIGINAL RECORD VERIFICATION
-- ============================================================

SELECT
    'BEFORE TRANSACTION' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    unit_cost,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 1;


-- ============================================================
-- START TRANSACTION AND SET ISOLATION LEVEL
-- ============================================================

BEGIN;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;


-- ============================================================
-- VERIFY ACTIVE ISOLATION LEVEL
-- ============================================================

SHOW transaction_isolation;


-- ============================================================
-- FIRST READ WITHIN THE TRANSACTION
-- ============================================================

SELECT
    'FIRST READ' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    unit_cost,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 1;


-- ============================================================
-- SECOND READ WITHIN THE SAME TRANSACTION
-- ============================================================

SELECT
    'SECOND READ' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    unit_cost,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 1;


-- ============================================================
-- COMPLETE THE TRANSACTION
-- ============================================================

COMMIT;


-- ============================================================
-- AFTER-COMMIT VERIFICATION
-- ============================================================

SELECT
    'AFTER COMMIT' AS verification_stage,
    spare_part_id,
    part_name,
    part_number,
    unit_cost,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 1;
