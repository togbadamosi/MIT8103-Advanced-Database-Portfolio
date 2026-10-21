-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 2: Query Processing and Optimisation
-- Case Study: ApexPetro Energy Limited
-- ============================================================

-- Query analysed:
-- Overdue work orders filtered by scheduled date and status.

-- The following partial index covers only work orders whose
-- status is neither Completed nor Cancelled.

CREATE INDEX idx_work_order_outstanding_schedule
ON work_order (scheduled_date)
WHERE status NOT IN ('Completed', 'Cancelled');

-- Refresh statistics for the indexed table.

ANALYZE work_order;

-- Evaluate the execution plan after creating the index.

EXPLAIN (ANALYZE, BUFFERS)
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
