-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 2: Query Processing and Optimisation
-- Case Study: ApexPetro Energy Limited
-- Synthetic Sample Data
-- ============================================================

-- All records in this file are fictional and created solely
-- for academic purposes.


-- ============================================================
-- 1. ASSETS
-- ============================================================

INSERT INTO asset (asset_name, asset_type, location, status)
VALUES
('Alpha Processing Facility', 'Processing Facility', 'Alpha Field', 'Active'),
('Bravo Flow Station', 'Flow Station', 'Bravo Field', 'Active'),
('Delta Storage Terminal', 'Storage Terminal', 'Delta Field', 'Active'),
('Echo Production Facility', 'Production Facility', 'Echo Field', 'Active');


-- ============================================================
-- 2. EQUIPMENT
-- ============================================================

INSERT INTO equipment
(asset_id, equipment_name, equipment_type, serial_number, status)
VALUES
(1, 'Crude Transfer Pump P-101', 'Pump', 'ATP-P101-001', 'Operational'),
(1, 'Gas Compressor C-101', 'Compressor', 'AGC-C101-001', 'Operational'),
(1, 'Separator V-101', 'Separator', 'ASV-V101-001', 'Operational'),
(2, 'Export Pump P-201', 'Pump', 'BEP-P201-001', 'Operational'),
(2, 'Generator G-201', 'Generator', 'BGN-G201-001', 'Operational'),
(2, 'Separator V-201', 'Separator', 'BSV-V201-001', 'Under Maintenance'),
(3, 'Storage Pump P-301', 'Pump', 'DSP-P301-001', 'Operational'),
(3, 'Loading Pump P-302', 'Pump', 'DLP-P302-001', 'Operational'),
(4, 'Production Pump P-401', 'Pump', 'EPP-P401-001', 'Operational'),
(4, 'Gas Compressor C-401', 'Compressor', 'EGC-C401-001', 'Operational');


-- ============================================================
-- 3. EMPLOYEES
-- ============================================================

INSERT INTO employee
(first_name, last_name, job_role, department)
VALUES
('Tunde', 'Adeyemi', 'Maintenance Engineer', 'Maintenance'),
('Amaka', 'Okafor', 'Mechanical Technician', 'Maintenance'),
('Ibrahim', 'Bello', 'Operations Engineer', 'Operations'),
('Chinedu', 'Eze', 'Inspection Engineer', 'Engineering'),
('Amina', 'Yusuf', 'Maintenance Supervisor', 'Maintenance'),
('Bola', 'Adesina', 'Inventory Officer', 'Supply Chain');


-- ============================================================
-- 4. WORK ORDERS
-- ============================================================

INSERT INTO work_order
(equipment_id, employee_id, maintenance_type, description,
 date_created, scheduled_date, status)
VALUES
(1, 1, 'Preventive', 'Routine inspection and servicing of crude transfer pump',
 '2026-08-01', '2026-08-05', 'Completed'),

(2, 2, 'Corrective', 'Investigate abnormal compressor vibration',
 '2026-08-10', '2026-08-11', 'Completed'),

(4, 1, 'Preventive', 'Quarterly servicing of export pump',
 '2026-09-01', '2026-09-05', 'Completed'),

(6, 2, 'Corrective', 'Repair separator level control problem',
 '2026-09-15', '2026-09-16', 'In Progress'),

(7, 5, 'Preventive', 'Routine maintenance of storage pump',
 '2026-09-20', '2026-09-25', 'Open'),

(9, 1, 'Corrective', 'Investigate reduced discharge pressure',
 '2026-09-28', '2026-09-29', 'Completed'),

(10, 2, 'Preventive', 'Monthly compressor inspection',
 '2026-10-01', '2026-10-05', 'Open'),

(1, 5, 'Corrective', 'Investigate pump seal leakage',
 '2026-10-03', '2026-10-04', 'In Progress'),

(5, 1, 'Preventive', 'Generator servicing and oil replacement',
 '2026-10-05', '2026-10-08', 'Open'),

(8, 2, 'Corrective', 'Investigate loading pump vibration',
 '2026-10-06', '2026-10-07', 'Cancelled');


-- ============================================================
-- 5. MAINTENANCE ACTIVITIES
-- ============================================================

INSERT INTO maintenance_activity
(work_order_id, activity_description, activity_date, activity_cost)
VALUES
(1, 'Inspected pump bearings and replaced lubrication oil', '2026-08-05', 85000.00),
(2, 'Replaced compressor bearing and realigned coupling', '2026-08-11', 350000.00),
(3, 'Serviced pump and replaced mechanical seal', '2026-09-05', 180000.00),
(4, 'Inspected level control system and replaced faulty component', '2026-09-16', 225000.00),
(6, 'Cleaned suction strainer and checked discharge valve', '2026-09-29', 95000.00),
(8, 'Inspected pump seal and identified seal deterioration', '2026-10-04', 75000.00);


-- ============================================================
-- 6. INSPECTIONS
-- ============================================================

INSERT INTO inspection
(equipment_id, employee_id, inspection_date, inspection_result, remarks)
VALUES
(1, 4, '2026-08-01', 'Satisfactory', 'No significant defect observed'),
(2, 4, '2026-08-10', 'Attention Required', 'Elevated vibration detected'),
(4, 4, '2026-09-01', 'Satisfactory', 'Equipment suitable for continued operation'),
(6, 4, '2026-09-15', 'Attention Required', 'Level control response inconsistent'),
(7, 4, '2026-09-20', 'Satisfactory', 'No abnormal condition observed'),
(9, 4, '2026-09-28', 'Attention Required', 'Reduced discharge pressure recorded'),
(10, 4, '2026-10-01', 'Satisfactory', 'Compressor condition acceptable');


-- ============================================================
-- 7. EQUIPMENT FAILURES
-- ============================================================

INSERT INTO equipment_failure
(equipment_id, failure_date, failure_description, failure_status)
VALUES
(2, '2026-08-10', 'Compressor bearing vibration exceeded acceptable level', 'Resolved'),
(6, '2026-09-15', 'Separator level control malfunction', 'Open'),
(9, '2026-09-28', 'Reduced pump discharge pressure', 'Resolved'),
(1, '2026-10-03', 'Mechanical seal leakage detected', 'Open'),
(2, '2026-07-15', 'Compressor coupling misalignment', 'Resolved'),
(1, '2026-06-20', 'Pump bearing temperature increase', 'Resolved');


-- ============================================================
-- 8. SPARE PARTS
-- ============================================================

INSERT INTO spare_part
(part_name, part_number, unit_cost, quantity_in_stock)
VALUES
('Pump Mechanical Seal', 'PMS-001', 120000.00, 20),
('Compressor Bearing', 'CBR-001', 250000.00, 10),
('Lubrication Oil', 'LBO-001', 15000.00, 100),
('Control Valve Positioner', 'CVP-001', 180000.00, 8),
('Pump Bearing', 'PBR-001', 95000.00, 15),
('Oil Filter', 'OFL-001', 25000.00, 30);


-- ============================================================
-- 9. MAINTENANCE PARTS
-- ============================================================

INSERT INTO maintenance_part
(activity_id, spare_part_id, quantity_used)
VALUES
(1, 3, 2),
(2, 2, 1),
(3, 1, 1),
(4, 4, 1),
(5, 5, 1),
(6, 1, 1);


-- ============================================================
-- 10. INVENTORY TRANSACTIONS
-- ============================================================

INSERT INTO inventory_transaction
(spare_part_id, transaction_date, transaction_type, quantity)
VALUES
(1, '2026-08-01', 'Receipt', 10),
(2, '2026-08-05', 'Receipt', 5),
(3, '2026-08-05', 'Issue', 2),
(2, '2026-08-11', 'Issue', 1),
(1, '2026-09-05', 'Issue', 1),
(4, '2026-09-16', 'Issue', 1),
(5, '2026-09-29', 'Issue', 1),
(1, '2026-10-04', 'Issue', 1);


-- ============================================================
-- 11. VENDORS
-- ============================================================

INSERT INTO vendor
(vendor_name, contact_person, phone, email)
VALUES
('Prime Industrial Supplies', 'Samuel Obi', '+2348000001001', 'sales@prime.example'),
('Delta Engineering Services', 'Fatima Lawal', '+2348000001002', 'support@delta.example'),
('Atlantic Equipment Solutions', 'Emeka Nwosu', '+2348000001003', 'info@atlantic.example');


-- ============================================================
-- 12. VENDOR-SPARE PART RELATIONSHIPS
-- ============================================================

INSERT INTO vendor_spare_part
(vendor_id, spare_part_id)
VALUES
(1, 1),
(1, 3),
(1, 5),
(2, 2),
(2, 4),
(3, 1),
(3, 2),
(3, 6);
