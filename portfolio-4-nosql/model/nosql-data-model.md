# Portfolio 4: NoSQL and Advanced Data Models
## NoSQL Data Model
### 1. Selected Use Case
The selected NoSQL use case is the ApexPetro Energy Limited Equipment Inspection and Condition Monitoring Store.

ApexPetro Energy Limited is a fictional oil and gas company created solely for this academic portfolio. The NoSQL model supports the storage and retrieval of equipment inspection records, condition-monitoring measurements, observations and recommendations.

The model remains consistent with the ApexPetro Operations & Maintenance Management System developed in Portfolios 1 to 3.

### 2. Selected NoSQL Model
A document-oriented NoSQL model was selected for this use case.

Each inspection is represented as a document containing:

inspection identification;

equipment details;

asset details;

inspection date;

inspector details;

equipment condition;

equipment-specific measurements;

inspection observations; and

maintenance recommendations.

The proposed collection is:

equipment_inspections

Each record in the collection represents one equipment inspection.

### 3. Rationale for Selecting a Document Model
A document-oriented model is appropriate because equipment inspection records may not all contain the same measurements.

For example:

pump inspections may record temperature, vibration and discharge pressure;

compressor inspections may record temperature, vibration, suction pressure and discharge pressure;

separator inspections may record operating pressure, liquid level and control-system response.

A fixed relational structure could require many optional columns or additional measurement tables to accommodate these variations.

The document model allows each inspection document to contain the measurements relevant to the equipment type being inspected.

The model also allows related information, such as equipment details, inspector details, measurements, observations and recommendations, to be stored together in one document.

### 4. Proposed Document Structure
A typical inspection document will have the following structure:

{
  "inspection_id": "INS-001",
  "equipment": {
    "equipment_id": 1,
    "equipment_name": "Crude Transfer Pump P-101",
    "equipment_type": "Pump",
    "serial_number": "ATP-P101-001"
  },
  "asset": {
    "asset_id": 1,
    "asset_name": "Alpha Processing Facility",
    "location": "Alpha Field"
  },
  "inspection_date": "2026-08-01",
  "inspector": {
    "employee_id": 4,
    "name": "Chinedu Eze",
    "role": "Inspection Engineer"
  },
  "condition": "Satisfactory",
  "measurements": {
    "temperature_c": 68.5,
    "vibration_mm_s": 2.8,
    "discharge_pressure_bar": 12.4
  },
  "observations": [
    "No abnormal vibration observed",
    "No visible leakage detected"
  ],
  "recommendations": [
    "Continue routine monitoring"
  ]
}

### 5. Document Fields
**Inspection Identification**

inspection_id uniquely identifies an inspection document.

Example:

**JSON**

"inspection_id": "INS-001"
 
**Equipment Subdocument**

The equipment subdocument stores selected information about the inspected equipment.

**JSON**

"equipment": {
"equipment_id": 1,
"equipment_name": "Crude Transfer Pump P-101",
"equipment_type": "Pump",
"serial_number": "ATP-P101-001"
}

**Asset Subdocument**

The asset subdocument identifies the operational asset to which the equipment belongs.

**JSON**

"asset": {
"asset_id": 1,
"asset_name": "Alpha Processing Facility",
"location": "Alpha Field"
}

**Inspector Subdocument**

The inspector subdocument records the employee who performed or recorded the inspection.

**JSON**

"inspector": {
"employee_id": 4,
"name": "Chinedu Eze",
"role": "Inspection Engineer"
}
Measurements Subdocument

The measurements subdocument contains equipment-specific condition-monitoring values.

For a pump, the measurements may include:

**JSON**

"measurements": {
"temperature_c": 68.5,
"vibration_mm_s": 2.8,
"discharge_pressure_bar": 12.4
}

A compressor inspection may instead include:

**JSON**

"measurements": {
"temperature_c": 82.0,
"vibration_mm_s": 5.7,
"suction_pressure_bar": 4.2,
"discharge_pressure_bar": 18.6
}

A separator inspection may include:

**JSON**

"measurements": {
"operating_pressure_bar": 9.8,
"liquid_level_percent": 72,
"control_response_seconds": 4.5
}

This variation demonstrates the flexible structure of the document model.

Observations Array

The observations array stores one or more inspection observations.

**JSON**

"observations": [
"Elevated vibration detected",
"Bearing noise observed during operation"
]
Recommendations Array

The recommendations array stores one or more recommended actions.

**JSON**

"recommendations": [
"Inspect compressor bearing",
"Schedule corrective maintenance"
]

### 6. Embedded Data Design

Equipment, asset and inspector details are embedded within each inspection document.

This design supports the retrieval of a complete inspection record in one operation without requiring separate joins to equipment, asset and employee collections.

The design intentionally duplicates a limited amount of descriptive information, such as equipment name and asset name, to support efficient inspection retrieval.

The relevant identifiers are also retained:

equipment_id

asset_id

employee_id

These identifiers provide traceability to the corresponding records in the relational ApexPetro database.

### 7. Arrays and Variable Attributes

The document model uses arrays for:

inspection observations; and

maintenance recommendations.

Arrays are suitable because one inspection may contain several observations and recommended actions.

The measurements subdocument is flexible and can contain different fields depending on the equipment type.

This avoids the need to include irrelevant or empty measurement fields in every inspection record.

### 8. Relationship with the Relational Database

The NoSQL model does not replace the complete ApexPetro relational database.

The relational model remains suitable for:

work orders;

employees;

vendors;

spare-parts inventory;

inventory transactions;

maintenance costs; and

business processes requiring strict referential integrity.

The document model is used specifically for inspection and condition-monitoring information that may contain variable measurements and nested observations.

The two models therefore support different requirements within the same ApexPetro scenario.

### 9. Proposed Collection

The proposed NoSQL collection is:

equipment_inspections

The collection will contain inspection documents for different equipment types, including:

pumps;

compressors;

separators;

generators; and

other operational equipment.

### 10. Proposed Query Requirements

The NoSQL implementation will demonstrate queries to:

Retrieve all inspection documents.

Retrieve inspections for a selected equipment item.

Retrieve inspections with an Attention Required condition.

Retrieve inspections for a selected operational asset.

Search embedded measurement fields.

Identify pump inspections with vibration above a specified threshold.

Update an inspection recommendation.

Summarise inspections by equipment type or condition.

### 11. Data Integrity Considerations

Although a document database provides structural flexibility, the inspection documents should still follow defined application rules.

The proposed rules include:

Each inspection must have a unique inspection_id.

Each inspection must identify the inspected equipment.

Each inspection must contain an inspection date.

Each inspection must identify the inspector.

Each inspection must contain an equipment condition.

Measurement values must use consistent units.

Observations and recommendations must be stored as arrays.

Equipment, asset and employee identifiers must correspond to the relevant ApexPetro records.

All documents and measurements used in this portfolio must be synthetic.

### 12. Model Summary

The ApexPetro Equipment Inspection and Condition Monitoring Store uses a document-oriented NoSQL model.

The model:

stores each inspection as one document;

embeds related equipment, asset and inspector information;

supports equipment-specific measurement fields;

uses arrays for observations and recommendations;

retains identifiers for traceability to the relational database; and

supports retrieval of complete inspection information without relational joins.

The document-oriented model is therefore suitable for inspection and condition-monitoring information with variable structures, nested values and multiple observations.
