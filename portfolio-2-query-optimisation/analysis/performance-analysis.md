# Portfolio 2: Query Processing and Optimisation
## Query Performance Analysis
**1. Query Analysed**

The optimisation exercise examined the overdue-work-orders query for the ApexPetro Energy Limited Operations & Maintenance Management System.

The query retrieves work orders that:

have a scheduled date before 11 October 2026;

have not been completed or cancelled; and

require equipment and asset details to be obtained through joins.

A fixed reference date was used to make the test reproducible.

The query joins the following tables:

work_order
equipment
asset

**2. Baseline Execution Plan**

The initial query was executed using:

EXPLAIN (ANALYZE, BUFFERS)

No additional optimisation index had been created at this stage.

The baseline execution plan showed:

a sequential scan on work_order;

a sequential scan on equipment;

a sequential scan on asset;

hash joins between the three tables;

a quicksort operation on scheduled_date;

five qualifying work-order records; and

five work-order records removed by the filter.

The estimated top-level cost was:

3.56..3.57

The sequential scan on work_order was reasonable because the table contained only ten records and the query returned five of them.

**3. Optimisation Applied**

A partial index was created on work_order.scheduled_date for work orders whose status was neither Completed nor Cancelled.

The optimisation was implemented as follows:

CREATE INDEX idx_work_order_outstanding_schedule

ON work_order (scheduled_date)

WHERE status NOT IN ('Completed', 'Cancelled');

The partial-index design was selected because the query filters by scheduled date and excludes completed and cancelled work orders.

After creating the index, the table statistics were refreshed using:

ANALYZE work_order;

The same overdue-work-orders query was then executed again using:

EXPLAIN (ANALYZE, BUFFERS)

**4. Post-Optimisation Execution Plan**

The post-optimisation execution plan showed:

estimated top-level cost of 3.56..3.57;

five qualifying work-order records;

five records removed by the work-order filter;

a sequential scan on work_order;

sequential scans on equipment and asset;

hash joins between the tables;

quicksort using 25 kB of memory;

planning time of 0.305 milliseconds; and

execution time of 0.049 milliseconds.

Although the partial index was created successfully, PostgreSQL did not select it for the query. The execution plan continued to use a sequential scan on the work_order table.

**5. Before-and-After Comparison**

The baseline and post-optimisation plans both:

used a sequential scan on work_order;

used hash joins;

used sequential scans on equipment and asset;

returned five work-order records;

removed five records through filtering; and

had an estimated top-level cost of 3.56..3.57.

The partial index therefore did not materially change the execution strategy for the current synthetic dataset.

The indexed execution recorded a planning time of 0.305 milliseconds and an execution time of 0.049 milliseconds. However, minor timing differences between individual executions should not be treated as conclusive evidence of performance improvement because the dataset is small and the same sequential-scan strategy was retained.

**6. Interpretation**

The result does not mean that the partial index was incorrectly designed. The work_order table contained only ten records, while five records satisfied the query conditions.

For a table of this size, reading the complete table can be less expensive than:

accessing an index;

locating the matching table rows; and

retrieving those rows from the table.

The query also returned half of the available work-order records, which made the filter relatively unselective.

PostgreSQL therefore retained the sequential scan because it estimated that this was the more economical execution strategy for the available data.

**7. Scalability Consideration**

The partial index may become more beneficial if:

the work_order table grows substantially;

only a small proportion of work orders remain outstanding;

the overdue-work-order query is executed frequently; and

the query continues to filter using conditions that match the partial-index predicate.

A larger and more selective dataset would provide a stronger basis for assessing whether PostgreSQL changes from a sequential scan to an index scan.

**8. Conclusion**

The optimisation exercise demonstrated that creating an index does not guarantee that PostgreSQL will use it.

The database planner evaluates factors such as:

table size;

estimated number of qualifying records;

query selectivity;

index-access cost; and

table-access cost.

For the current ApexPetro synthetic dataset, PostgreSQL retained the sequential scan because the table was small and the query returned a relatively large proportion of its records.

The exercise demonstrated the importance of using actual execution plans rather than assuming that an index automatically improves query performance.
