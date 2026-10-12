# Portfolio 1: Database Design and Modelling
## Business Rules
The relations and operational requirements between the ApexPetro Energy Limited Operations & Maintenance Management System are established as follows:

**1. Assets and Equipment**

1. One or more equipment items can be attached to an asset.

2. All equipment items need to be assigned to an asset.

3. The equipment identifier is the name of the equipment and must be unique for each equipment item.

4. Each equipment item can have several work orders, inspections and failure records throughout its use.

**2. Employees and Work Orders**

5. An employee can be assigned to many work orders throughout their career.

6. All work orders must be related to a single piece of equipment.

7. Each work order must have an employee responsible for the work.

8. Each work order should be a status (Open, In Progress, Completed or Cancelled).

9. One or many maintenance activities can be carried out on a single work order.

**3. Maintenance Activities**

10. All maintenance activities must be associated with one work order.

11. A work order could be for preventive maintenance or corrective maintenance.

12. Each maintenance activity has relevant information to it such as Activity, Date, and associated cost.

13. Completed maintenance activities is part of the maintenance history of the related equipment.

**4. Inspections**

14. All inspections must be associated with one piece of equipment.

15. Equipment items can be inspected several times throughout the time period.

16. The result of an inspection and the date of the inspection should be recorded as part of each inspection.

17. Any inspection should be done or recorded by an employee.

**5. Equipment Failures**

18. All failure records should be for a single piece of equipment.

19. Equipment failures can occur more than once to an equipment item over time.

20. Failure Record should contain Date of failure and Failure description.

21. Failure could lead to the generation of a corrective maintenance work order.

**6. Spare Parts and Inventory Transactions**

22. A unique identifier needs to be assigned to each spare part.

23. A spare part can be used in several maintenance activities.

24. Some maintenance activities will need several spare parts.

25. All the number of spares utilised for a maintenance operation must be documented.

26. Changes in the inventory of spares should be documented in the inventory transactions.

27. All inventory transactions shall be related to one spare part.

**7. Vendors**

28. A vendor shall provide more than one spare part.

29. One or more vendors may provide an alternate part.

30. The vendor's data should be kept in order to be able to identify the supplies of spares.

**8. Data Integrity Rules**

31. Primary identifiers are unique values that identify a single record in each entity.

32. Relationships between entities in the database should be kept through proper foreign keys.

33. All operational information is required to be filled.

34. Negative values of quantities or monetary amounts are not allowed when they would not make sense.

35. All dates recorded for maintenance, inspections, failures and inventory transactions should be valid dates.
