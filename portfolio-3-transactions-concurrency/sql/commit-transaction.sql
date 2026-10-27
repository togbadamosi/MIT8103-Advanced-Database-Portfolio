-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Case Study: ApexPetro Energy Limited
--
-- Successful Multi-Step Transaction Using COMMIT
-- ============================================================

-- Scenario:
-- Work Order 7 relates to the monthly inspection of
-- Gas Compressor C-401.
--
-- Completing the work requires the database to:
-- 1. Record the maintenance activity.
-- 2. Record the oil filter used.
-- 3. Reduce oil-filter stock by one unit.
-- 4. Record the inventory issue.
-- 5. Update the work order to Completed.
-- 6. Permanently save all changes using COMMIT.


-- ============================================================
-- BEFORE-TRANSACTION VERIFICATION
-- ============================================================

-- Verify the original work-order status.

SELECT
    work_order_id,
    description,
    scheduled_date,
    status
FROM work_order
WHERE work_order_id = 7;


-- Verify the original Oil Filter stock quantity.

SELECT
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 6;


-- ============================================================
-- START TRANSACTION
-- ============================================================

BEGIN;


-- ============================================================
-- STEP 1:
-- Record the maintenance activity and capture its generated ID.
--
-- STEP 2:
-- Use the generated activity ID to record the Oil Filter used.
-- ============================================================

WITH new_activity AS (
    INSERT INTO maintenance_activity (
        work_order_id,
        activity_description,
        activity_date,
        activity_cost
    )
    VALUES (
        7,
        'Completed monthly compressor inspection and replaced oil filter',
        '2026-10-05',
        60000.00
    )
    RETURNING activity_id
)
INSERT INTO maintenance_part (
    activity_id,
    spare_part_id,
    quantity_used
)
SELECT
    activity_id,
    6,
    1
FROM new_activity;


-- ============================================================
-- STEP 3:
-- Reduce Oil Filter stock by one unit.
--
-- The WHERE condition prevents stock from becoming negative.
-- ============================================================

UPDATE spare_part
SET quantity_in_stock = quantity_in_stock - 1
WHERE spare_part_id = 6
  AND quantity_in_stock >= 1;


-- ============================================================
-- STEP 4:
-- Record the inventory issue.
-- ============================================================

INSERT INTO inventory_transaction (
    spare_part_id,
    transaction_date,
    transaction_type,
    quantity
)
VALUES (
    6,
    '2026-10-05',
    'Issue',
    1
);


-- ============================================================
-- STEP 5:
-- Update the work-order status to Completed.
-- ============================================================

UPDATE work_order
SET status = 'Completed'
WHERE work_order_id = 7;


-- ============================================================
-- STEP 6:
-- Permanently save all transaction changes.
-- ============================================================

COMMIT;


-- ============================================================
-- AFTER-COMMIT VERIFICATION
-- ============================================================

-- Confirm the work order is now Completed.

SELECT
    work_order_id,
    description,
    scheduled_date,
    status
FROM work_order
WHERE work_order_id = 7;


-- Confirm Oil Filter stock reduced from 30 to 29.

SELECT
    spare_part_id,
    part_name,
    part_number,
    quantity_in_stock
FROM spare_part
WHERE spare_part_id = 6;


-- Confirm the maintenance activity was recorded.

SELECT
    activity_id,
    work_order_id,
    activity_description,
    activity_date,
    activity_cost
FROM maintenance_activity
WHERE work_order_id = 7;


-- Confirm the spare part was linked to the maintenance activity.

SELECT
    mp.activity_id,
    mp.spare_part_id,
    sp.part_name,
    mp.quantity_used
FROM maintenance_part mp
JOIN maintenance_activity ma
    ON mp.activity_id = ma.activity_id
JOIN spare_part sp
    ON mp.spare_part_id = sp.spare_part_id
WHERE ma.work_order_id = 7;


-- Confirm the inventory issue was recorded.

SELECT
    transaction_id,
    spare_part_id,
    transaction_date,
    transaction_type,
    quantity
FROM inventory_transaction
WHERE spare_part_id = 6
  AND transaction_type = 'Issue'
  AND transaction_date = DATE '2026-10-05';
