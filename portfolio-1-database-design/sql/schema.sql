-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Portfolio 1: Database Design and Modelling
-- Case Study: ApexPetro Energy Limited
-- Operations & Maintenance Management System
-- ============================================================


-- ============================================================
-- 1. ASSET
-- ============================================================

CREATE TABLE asset (
    asset_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    asset_name VARCHAR(100) NOT NULL,
    asset_type VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL
);


-- ============================================================
-- 2. EQUIPMENT
-- Each equipment item belongs to one asset.
-- ============================================================

CREATE TABLE equipment (
    equipment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    asset_id INTEGER NOT NULL,
    equipment_name VARCHAR(100) NOT NULL,
    equipment_type VARCHAR(50) NOT NULL,
    serial_number VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL,

    CONSTRAINT fk_equipment_asset
        FOREIGN KEY (asset_id)
        REFERENCES asset(asset_id)
);


-- ============================================================
-- 3. EMPLOYEE
-- ============================================================

CREATE TABLE employee (
    employee_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_role VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL
);


-- ============================================================
-- 4. WORK ORDER
-- Each work order relates to one equipment item and
-- has one responsible employee.
-- ============================================================

CREATE TABLE work_order (
    work_order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    equipment_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    maintenance_type VARCHAR(20) NOT NULL,
    description VARCHAR(500) NOT NULL,
    date_created DATE NOT NULL,
    scheduled_date DATE,
    status VARCHAR(20) NOT NULL,

    CONSTRAINT fk_workorder_equipment
        FOREIGN KEY (equipment_id)
        REFERENCES equipment(equipment_id),

    CONSTRAINT fk_workorder_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CONSTRAINT chk_workorder_type
        CHECK (maintenance_type IN ('Preventive', 'Corrective')),

    CONSTRAINT chk_workorder_status
        CHECK (status IN ('Open', 'In Progress', 'Completed', 'Cancelled')),

    CONSTRAINT chk_workorder_schedule
        CHECK (scheduled_date IS NULL OR scheduled_date >= date_created)
);


-- ============================================================
-- 5. MAINTENANCE ACTIVITY
-- Each maintenance activity belongs to one work order.
-- ============================================================

CREATE TABLE maintenance_activity (
    activity_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    work_order_id INTEGER NOT NULL,
    activity_description VARCHAR(500) NOT NULL,
    activity_date DATE NOT NULL,
    activity_cost DECIMAL(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_activity_workorder
        FOREIGN KEY (work_order_id)
        REFERENCES work_order(work_order_id),

    CONSTRAINT chk_activity_cost
        CHECK (activity_cost >= 0)
);


-- ============================================================
-- 6. INSPECTION
-- Each inspection relates to one equipment item and
-- is performed or recorded by one employee.
-- ============================================================

CREATE TABLE inspection (
    inspection_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    equipment_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    inspection_date DATE NOT NULL,
    inspection_result VARCHAR(200) NOT NULL,
    remarks VARCHAR(500),

    CONSTRAINT fk_inspection_equipment
        FOREIGN KEY (equipment_id)
        REFERENCES equipment(equipment_id),

    CONSTRAINT fk_inspection_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
);


-- ============================================================
-- 7. EQUIPMENT FAILURE
-- An equipment item may have multiple failure records.
-- ============================================================

CREATE TABLE equipment_failure (
    failure_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    equipment_id INTEGER NOT NULL,
    failure_date DATE NOT NULL,
    failure_description VARCHAR(500) NOT NULL,
    failure_status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_failure_equipment
        FOREIGN KEY (equipment_id)
        REFERENCES equipment(equipment_id)
);


-- ============================================================
-- 8. SPARE PART
-- ============================================================

CREATE TABLE spare_part (
    spare_part_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    part_name VARCHAR(100) NOT NULL,
    part_number VARCHAR(100) NOT NULL UNIQUE,
    unit_cost DECIMAL(12,2) NOT NULL,
    quantity_in_stock INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT chk_sparepart_cost
        CHECK (unit_cost >= 0),

    CONSTRAINT chk_sparepart_stock
        CHECK (quantity_in_stock >= 0)
);


-- ============================================================
-- 9. MAINTENANCE PART
-- Associative table resolving the many-to-many relationship
-- between maintenance activities and spare parts.
-- ============================================================

CREATE TABLE maintenance_part (
    activity_id INTEGER NOT NULL,
    spare_part_id INTEGER NOT NULL,
    quantity_used INTEGER NOT NULL,

    CONSTRAINT pk_maintenance_part
        PRIMARY KEY (activity_id, spare_part_id),

    CONSTRAINT fk_maintenancepart_activity
        FOREIGN KEY (activity_id)
        REFERENCES maintenance_activity(activity_id),

    CONSTRAINT fk_maintenancepart_sparepart
        FOREIGN KEY (spare_part_id)
        REFERENCES spare_part(spare_part_id),

    CONSTRAINT chk_quantity_used
        CHECK (quantity_used > 0)
);


-- ============================================================
-- 10. INVENTORY TRANSACTION
-- Each inventory transaction relates to one spare part.
-- ============================================================

CREATE TABLE inventory_transaction (
    transaction_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    spare_part_id INTEGER NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    quantity INTEGER NOT NULL,

    CONSTRAINT fk_inventory_sparepart
        FOREIGN KEY (spare_part_id)
        REFERENCES spare_part(spare_part_id),

    CONSTRAINT chk_transaction_type
        CHECK (transaction_type IN ('Receipt', 'Issue', 'Adjustment')),

    CONSTRAINT chk_inventory_quantity
        CHECK (quantity > 0)
);


-- ============================================================
-- 11. VENDOR
-- ============================================================

CREATE TABLE vendor (
    vendor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vendor_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(30),
    email VARCHAR(150)
);


-- ============================================================
-- 12. VENDOR SPARE PART
-- Associative table resolving the many-to-many relationship
-- between vendors and spare parts.
-- ============================================================

CREATE TABLE vendor_spare_part (
    vendor_id INTEGER NOT NULL,
    spare_part_id INTEGER NOT NULL,

    CONSTRAINT pk_vendor_spare_part
        PRIMARY KEY (vendor_id, spare_part_id),

    CONSTRAINT fk_vendorsparepart_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES vendor(vendor_id),

    CONSTRAINT fk_vendorsparepart_sparepart
        FOREIGN KEY (spare_part_id)
        REFERENCES spare_part(spare_part_id)
);
