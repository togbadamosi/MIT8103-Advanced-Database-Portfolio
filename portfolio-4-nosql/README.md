# Portfolio 4: NoSQL and Advanced Data Models
## Overview
Portfolio 4 applies a NoSQL document-oriented data model to the ApexPetro Energy Limited Operations & Maintenance Management System.

The portfolio focuses on equipment inspection and condition-monitoring information, where different equipment types may generate different measurements, observations and recommendations.

A document-oriented approach is used to represent inspection information using nested objects and arrays while maintaining the same fictional ApexPetro case study developed in the previous portfolio activities.

All information and records used in this activity are synthetic and created solely for academic purposes.

## Completed Activities
This portfolio demonstrates:

1. Design of a NoSQL document model for equipment inspection and condition-monitoring information.
2. Creation of synthetic inspection documents.
3. Practical implementation of the document model.
4. Queries against normal and embedded document fields.
5. Updating NoSQL documents.
6. Analysis of the suitability of the document model for the selected use case.
7. Practical execution and screenshot evidence.

## Technical Reflection
The main objective of this portfolio activity was to understand how a document-oriented NoSQL model can complement a relational database when data structures vary between records.

The ApexPetro inspection use case demonstrated this clearly because different equipment types require different condition-monitoring measurements. Pumps, compressors, separators and generators were therefore represented using the same overall document structure while allowing the embedded measurements object to contain equipment-specific attributes.

A significant learning point was the use of embedded documents and arrays. Equipment, asset and inspector information could be represented inside each inspection document, while observations and recommendations could contain multiple values without requiring additional relational tables.

The practical implementation also demonstrated that embedded fields can be queried directly. Queries were successfully executed against asset names, equipment types, vibration measurements and temperature measurements.

Updating inspection INS-002 demonstrated that an existing document could be modified by adding a new recommendation. The aggregation exercises further demonstrated that NoSQL documents can support analytical operations such as grouping inspections by condition and equipment type.

The exercise also highlighted an important design consideration: flexibility should not be interpreted as absence of structure. Consistent identifiers, measurement units and validation rules remain important for maintaining usable inspection data.

This activity improved my understanding of document modelling, embedded objects, arrays, flexible schemas, nested-field queries, document updates and aggregation. It also showed how a NoSQL document store and a relational database can address different data requirements within the same application.
