-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 2: Query Processing and Optimisation
-- Case Study: ApexPetro Energy Limited
-- SQL Queries
-- ============================================================


-- ============================================================
-- QUERY 1: OUTSTANDING MAINTENANCE WORK ORDERS
-- Purpose: Identify equipment with open or in-progress work orders.
-- ============================================================

SELECT
    wo.work_order_id,
    e.equipment_name,
    a.asset_name,
    wo.maintenance_type,
    wo.scheduled_date,
    wo.status
FROM work_order wo
JOIN equipment e
    ON wo.equipment_id = e.equipment_id
JOIN asset a
    ON e.asset_id = a.asset_id
WHERE wo.status IN ('Open', 'In Progress')
ORDER BY wo.scheduled_date;


-- ============================================================
-- QUERY 2: EQUIPMENT MAINTENANCE HISTORY
-- Purpose: Retrieve maintenance history for Crude Transfer Pump P-101.
-- ============================================================

SELECT
    e.equipment_name,
    wo.work_order_id,
    wo.maintenance_type,
    wo.description,
    wo.status,
    ma.activity_description,
    ma.activity_date,
    ma.activity_cost
FROM equipment e
JOIN work_order wo
    ON e.equipment_id = wo.equipment_id
LEFT JOIN maintenance_activity ma
    ON wo.work_order_id = ma.work_order_id
WHERE e.equipment_name = 'Crude Transfer Pump P-101'
ORDER BY wo.date_created;


-- ============================================================
-- QUERY 3: TOTAL MAINTENANCE COST BY ASSET
-- Purpose: Calculate maintenance expenditure for each asset.
-- ============================================================

SELECT
    a.asset_id,
    a.asset_name,
    COALESCE(SUM(ma.activity_cost), 0) AS total_maintenance_cost
FROM asset a
LEFT JOIN equipment e
    ON a.asset_id = e.asset_id
LEFT JOIN work_order wo
    ON e.equipment_id = wo.equipment_id
LEFT JOIN maintenance_activity ma
    ON wo.work_order_id = ma.work_order_id
GROUP BY
    a.asset_id,
    a.asset_name
ORDER BY total_maintenance_cost DESC;


-- ============================================================
-- QUERY 4: EQUIPMENT FAILURE FREQUENCY
-- Purpose: Identify equipment with the highest recorded failures.
-- ============================================================

SELECT
    e.equipment_id,
    e.equipment_name,
    a.asset_name,
    COUNT(ef.failure_id) AS failure_count
FROM equipment e
JOIN asset a
    ON e.asset_id = a.asset_id
LEFT JOIN equipment_failure ef
    ON e.equipment_id = ef.equipment_id
GROUP BY
    e.equipment_id,
    e.equipment_name,
    a.asset_name
ORDER BY failure_count DESC, e.equipment_name;


-- ============================================================
-- QUERY 5: SPARE-PART CONSUMPTION
-- Purpose: Determine spare-part quantities consumed in maintenance.
-- ============================================================

SELECT
    sp.spare_part_id,
    sp.part_name,
    sp.part_number,
    COALESCE(SUM(mp.quantity_used), 0) AS total_quantity_used
FROM spare_part sp
LEFT JOIN maintenance_part mp
    ON sp.spare_part_id = mp.spare_part_id
GROUP BY
    sp.spare_part_id,
    sp.part_name,
    sp.part_number
ORDER BY total_quantity_used DESC, sp.part_name;


-- ============================================================
-- QUERY 6: OVERDUE WORK ORDERS
-- Purpose: Identify work orders whose scheduled dates have passed
-- and which are not completed or cancelled.
-- Reference date fixed for reproducible academic testing.
-- ============================================================

SELECT
    wo.work_order_id,
    e.equipment_name,
    a.asset_name,
    wo.scheduled_date,
    wo.status,
    wo.maintenance_type
FROM work_order wo
JOIN equipment e
    ON wo.equipment_id = e.equipment_id
JOIN asset a
    ON e.asset_id = a.asset_id
WHERE wo.scheduled_date < DATE '2026-10-11'
  AND wo.status NOT IN ('Completed', 'Cancelled')
ORDER BY wo.scheduled_date;


-- ============================================================
-- QUERY 7: WORK ORDERS BY RESPONSIBLE EMPLOYEE
-- Purpose: Summarise work-order responsibility by employee.
-- ============================================================

SELECT
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    emp.job_role,
    COUNT(wo.work_order_id) AS work_order_count
FROM employee emp
LEFT JOIN work_order wo
    ON emp.employee_id = wo.employee_id
GROUP BY
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    emp.job_role
ORDER BY work_order_count DESC, emp.last_name;


-- ============================================================
-- QUERY 8: ASSET MAINTENANCE PERFORMANCE SUMMARY
-- Purpose: Provide a consolidated asset-level maintenance summary.
-- This query will be considered for execution-plan analysis.
-- ============================================================

SELECT
    a.asset_id,
    a.asset_name,
    COUNT(DISTINCT e.equipment_id) AS equipment_count,
    COUNT(DISTINCT wo.work_order_id) AS work_order_count,
    COUNT(DISTINCT ef.failure_id) AS failure_count,
    COALESCE(SUM(ma.activity_cost), 0) AS total_maintenance_cost
FROM asset a
LEFT JOIN equipment e
    ON a.asset_id = e.asset_id
LEFT JOIN work_order wo
    ON e.equipment_id = wo.equipment_id
LEFT JOIN maintenance_activity ma
    ON wo.work_order_id = ma.work_order_id
LEFT JOIN equipment_failure ef
    ON e.equipment_id = ef.equipment_id
GROUP BY
    a.asset_id,
    a.asset_name
ORDER BY total_maintenance_cost DESC;
