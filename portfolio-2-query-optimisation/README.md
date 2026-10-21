# Portfolio 2: Query Processing and Optimisation
## Overview
Portfolio 2 applies SQL query processing and optimisation techniques to the ApexPetro Energy Limited Operations & Maintenance Management System developed in Portfolio 1.

The activity uses synthetic data created solely for academic purposes. The Portfolio 1 relational schema provides the database structure, while Portfolio 2 populates the database, executes operational SQL queries, examines execution plans and evaluates a partial-index optimisation.

## Portfolio 2 Deliverables

**1. Synthetic Sample Data**

Synthetic records were created for the following database tables:

Asset

Equipment

Employee

Work Order

Maintenance Activity

Inspection

Equipment Failure

Spare Part

Maintenance Part

Inventory Transaction

Vendor

Vendor Spare Part

The sample data was successfully executed and verified across all 12 tables.

See: sql/sample-data.sql

**2. Operational SQL Queries**

Eight operational queries were developed and tested:

Outstanding maintenance work orders

Equipment maintenance history

Total maintenance cost by asset

Equipment failure frequency

Spare-part consumption

Overdue work orders

Work orders by responsible employee

Asset maintenance performance summary

The queries demonstrate filtering, joins, aggregation, grouping, sorting, common table expressions and the handling of multiple one-to-many relationships.

See: sql/queries.sql

**3. Query Correction and Validation**

The initial asset maintenance summary produced an overstated maintenance cost because maintenance activities and equipment failures were joined simultaneously at detail level.

The resulting join multiplication duplicated maintenance-cost records. The query was corrected by aggregating equipment, work orders, maintenance costs and failures separately before joining the summaries at asset level.

The corrected result was reconciled with the previously validated maintenance-cost query.

**4. Execution-Plan Analysis**

The overdue-work-orders query was analysed using:

EXPLAIN (ANALYZE, BUFFERS)

The baseline execution plan showed:

sequential scans;

hash joins;

a quicksort operation;

five qualifying work orders; and

five records removed by the filter.

**5. Query Optimisation**

A partial index was created on the scheduled date of outstanding work orders:

CREATE INDEX idx_work_order_outstanding_schedule
ON work_order (scheduled_date)
WHERE status NOT IN ('Completed', 'Cancelled');

The query was executed again after creating the index and refreshing the relevant table statistics.

PostgreSQL retained a sequential scan because the work_order table contained only ten records and the query returned five of them. For the small synthetic dataset, a sequential scan remained more economical than using the index.

See: sql/optimisation.sql

**6. Performance Analysis**

The baseline and post-optimisation execution plans were compared using estimated cost, access methods, rows processed, filtering, planning time and execution time.

The analysis concluded that creating an index does not guarantee its use. PostgreSQL selects an execution strategy based on table size, query selectivity and estimated access cost.

See: analysis/performance-analysis.md

**7. Supporting Evidence**

The evidence folder contains screenshots showing:

successful sample-data loading and verification;

results of all eight operational queries;

the baseline execution plan; and

the post-index execution plan.

See: evidence/README.md

## Technical Reflection

The main objective of this activity was to translate the ApexPetro relational design into meaningful operational queries. The queries were designed to answer realistic maintenance-management questions relating to outstanding work orders, maintenance history, expenditure, failures, spare-parts usage, overdue activities and employee responsibilities.

A significant challenge arose when the initial asset maintenance summary joined maintenance activities and equipment failures simultaneously. Although the query executed successfully, the maintenance cost for one asset was overstated because multiple one-to-many relationships caused row multiplication. Comparing the result with the earlier maintenance-cost query helped identify the inconsistency. The query was corrected by aggregating the related data separately before combining the summaries.

The execution-plan exercise also demonstrated that creating an index does not automatically improve a query or cause PostgreSQL to use an index scan. The partial index was logically aligned with the overdue-work-orders filter, but PostgreSQL retained a sequential scan because the table was small and half of its records met the query conditions.

This activity improved my understanding of SQL joins, aggregation, result validation, execution plans, partial indexes and query-planner decisions. It also reinforced the importance of reconciling query results and using execution evidence rather than assuming that syntactically successful SQL is logically correct or optimised.

## Summary

Portfolio 2 demonstrates the successful population, querying and performance analysis of the ApexPetro relational database.

The portfolio provides evidence of:

meaningful SQL query development;

accurate query-result validation;

correction of join-multiplication errors;

execution-plan interpretation;

partial-index implementation; and

evidence-based performance analysis.

The results provide the foundation for the transaction and concurrency work to be undertaken in Portfolio 3.
