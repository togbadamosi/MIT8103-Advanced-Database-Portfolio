# Portfolio 4: NoSQL and Advanced Data Models
## NoSQL Suitability Analysis
### 1. Overview
Portfolio 4 applies a document-oriented NoSQL model to the ApexPetro Energy Limited Equipment Inspection and Condition Monitoring use case.

The relational database developed in Portfolio 1 remains appropriate for structured operational transactions such as work orders, inventory movements, employees, vendors and maintenance costs.

The NoSQL implementation focuses specifically on inspection and condition-monitoring records, where different equipment types may generate different measurements, observations and recommendations.

### 2. Why a Document Model Was Selected
Equipment inspections do not always share an identical structure.

For example:

pump inspections record temperature, vibration and discharge pressure;

compressor inspections include temperature, vibration, suction pressure and discharge pressure;

separator inspections contain operating pressure, liquid level and control-response measurements;

generator inspections contain engine temperature, oil pressure, output voltage and frequency.

A document model allows these different measurement structures to be represented without requiring every inspection record to contain the same measurement fields.

### 3. Embedded Data
The inspection documents embed related information such as:

equipment details;

asset details;

inspector details; and

measurement values.

For example, equipment details are stored inside an embedded equipment object, while asset information is stored inside an embedded asset object.

This structure allowed inspection information to be retrieved as one document without requiring relational joins.

The practical implementation demonstrated queries against embedded fields such as:

asset.asset_name

equipment.equipment_type

measurements.vibration_mm_s

measurements.temperature_c

### 4. Arrays
The document model uses arrays for:

observations; and

recommendations.

An inspection can therefore contain several observations and recommended actions within the same document.

The practical implementation also demonstrated updating an existing inspection document by adding a further recommendation to inspection INS-002.

### 5. Flexible Measurement Structure
One of the main advantages demonstrated by the implementation was the ability to store different measurement attributes for different equipment types.

For example, a pump document could contain:

temperature;

vibration; and

discharge pressure.

A generator document could instead contain:

engine temperature;

oil pressure;

output voltage; and

frequency.

This flexibility is suitable for condition-monitoring information because equipment types do not necessarily produce identical operating measurements.

### 6. Practical Query Results
Eight synthetic inspection documents were inserted into the equipment_inspections collection.

The practical queries demonstrated:

retrieval of inspections requiring attention;

queries against embedded asset fields;

queries against equipment-specific measurement fields;

numerical comparison against embedded measurements; and

retrieval of documents using multiple conditions.

The Attention Required query returned four relevant inspection documents.

The Bravo Flow Station embedded-field query returned three documents.

The pump vibration query identified the pump inspection whose vibration measurement exceeded the defined threshold.

The compressor-temperature query identified the compressor inspection meeting the specified temperature condition.

### 7. Document Update
Inspection INS-002 was updated by adding the recommendation:

Review compressor vibration after corrective maintenance

This demonstrated that an individual document and its recommendations array could be modified after insertion.

The updated document was then retrieved to verify the change.

### 8. Aggregation
Aggregation was used to analyse the inspection documents.

Grouping by condition demonstrated that the synthetic dataset contained:

four Satisfactory inspections; and

four Attention Required inspections.

A further aggregation grouped inspections by embedded equipment type and calculated both:

total inspection count; and

number of inspections requiring attention.

This demonstrated analytical processing over document-based records.

### 9. Relationship with the Relational Model
The NoSQL implementation is not intended to replace the complete ApexPetro relational database.

The relational model remains more appropriate for structured transactional areas such as:

work orders;

maintenance transactions;

employees;

inventory;

spare parts;

vendors; and

financial maintenance records.

These areas benefit from clearly defined relationships, keys, constraints and referential integrity.

The document-oriented model is used specifically where the data has a more flexible structure, particularly equipment inspections and condition-monitoring measurements.

### 10. Advantages of the Document Model
For the selected ApexPetro inspection use case, the document model provides:

flexible measurement structures;

nested equipment and asset information;

arrays for multiple observations and recommendations;

direct querying of embedded attributes; and

the ability to retrieve related inspection information as one document.

### 11. Considerations and Limitations
The flexibility of a document database also requires careful data-management rules.

For example:

measurement units should remain consistent;

inspection identifiers should remain unique;

equipment and asset identifiers should remain aligned with the relational system;

embedded descriptive information may need updating if the corresponding master information changes; and

applications should validate required fields to avoid inconsistent document structures.

The portfolio therefore uses the document model selectively rather than treating it as a replacement for all relational data.

### 12. Conclusion
The practical implementation demonstrated that a document-oriented NoSQL model is suitable for the ApexPetro equipment inspection and condition-monitoring use case.

The model successfully represented different equipment measurement structures, embedded related information, stored arrays of observations and recommendations, supported nested-field queries, allowed document updates and supported aggregation.

The exercise also demonstrated that relational and NoSQL databases can serve complementary purposes within the same business scenario.
