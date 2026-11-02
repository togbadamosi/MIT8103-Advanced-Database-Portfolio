// ============================================================
// MIT 8103 Advanced Database Systems
// Portfolio 4: NoSQL and Advanced Data Models
// Case Study: ApexPetro Energy Limited
//
// MongoDB Inspection Queries
// ============================================================

// Database name:
// apexpetro_nosql
//
// Collection name:
// equipment_inspections
//
// Prerequisite:
// The eight documents in sample-documents.json must be
// imported into the equipment_inspections collection before
// these queries are executed.


// ============================================================
// 1. VERIFY THE NUMBER OF DOCUMENTS
// Purpose: Confirm that all eight inspection documents exist.
// Expected result: 8
// ============================================================

db.equipment_inspections.countDocuments({});


// ============================================================
// 2. RETRIEVE ALL INSPECTION DOCUMENTS
// Purpose: Display all equipment inspection records.
// ============================================================

db.equipment_inspections.find({});


// ============================================================
// 3. RETRIEVE SELECTED FIELDS FROM ALL INSPECTIONS
// Purpose: Display a concise inspection summary.
// The _id field is excluded from the output.
// ============================================================

db.equipment_inspections.find(
  {},
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    "equipment.equipment_type": 1,
    "asset.asset_name": 1,
    inspection_date: 1,
    condition: 1
  }
).sort({
  inspection_id: 1
});


// ============================================================
// 4. QUERY BY EMBEDDED EQUIPMENT FIELD
// Purpose: Retrieve inspections for Crude Transfer Pump P-101.
// ============================================================

db.equipment_inspections.find(
  {
    "equipment.equipment_name": "Crude Transfer Pump P-101"
  },
  {
    _id: 0,
    inspection_id: 1,
    equipment: 1,
    inspection_date: 1,
    condition: 1,
    measurements: 1,
    observations: 1,
    recommendations: 1
  }
);


// ============================================================
// 5. QUERY INSPECTIONS REQUIRING ATTENTION
// Purpose: Retrieve all inspections whose condition is
// Attention Required.
// Expected result: INS-002, INS-004, INS-006 and INS-008.
// ============================================================

db.equipment_inspections.find(
  {
    condition: "Attention Required"
  },
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    "equipment.equipment_type": 1,
    "asset.asset_name": 1,
    inspection_date: 1,
    condition: 1,
    recommendations: 1
  }
).sort({
  inspection_date: 1
});


// ============================================================
// 6. QUERY BY EMBEDDED ASSET FIELD
// Purpose: Retrieve inspections carried out at
// Bravo Flow Station.
// Expected result: INS-003, INS-004 and INS-008.
// ============================================================

db.equipment_inspections.find(
  {
    "asset.asset_name": "Bravo Flow Station"
  },
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    "equipment.equipment_type": 1,
    inspection_date: 1,
    condition: 1
  }
).sort({
  inspection_date: 1
});


// ============================================================
// 7. QUERY PUMP INSPECTIONS
// Purpose: Retrieve inspection documents for equipment
// classified as Pump.
// Expected result: INS-001, INS-003, INS-005 and INS-006.
// ============================================================

db.equipment_inspections.find(
  {
    "equipment.equipment_type": "Pump"
  },
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    "asset.asset_name": 1,
    condition: 1,
    measurements: 1
  }
).sort({
  inspection_id: 1
});


// ============================================================
// 8. QUERY AN EMBEDDED MEASUREMENT FIELD
// Purpose: Identify pump inspections where vibration exceeds
// 4.0 millimetres per second.
// Expected result: INS-006.
// ============================================================

db.equipment_inspections.find(
  {
    "equipment.equipment_type": "Pump",
    "measurements.vibration_mm_s": {
      $gt: 4.0
    }
  },
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    "asset.asset_name": 1,
    condition: 1,
    "measurements.vibration_mm_s": 1,
    recommendations: 1
  }
);


// ============================================================
// 9. QUERY COMPRESSOR TEMPERATURE
// Purpose: Retrieve compressor inspections with temperature
// greater than or equal to 80 degrees Celsius.
// Expected result: INS-002.
// ============================================================

db.equipment_inspections.find(
  {
    "equipment.equipment_type": "Compressor",
    "measurements.temperature_c": {
      $gte: 80
    }
  },
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    condition: 1,
    "measurements.temperature_c": 1,
    "measurements.vibration_mm_s": 1
  }
);


// ============================================================
// 10. QUERY OBSERVATIONS ARRAY
// Purpose: Retrieve documents whose observations contain
// text relating to vibration.
// ============================================================

db.equipment_inspections.find(
  {
    observations: {
      $elemMatch: {
        $regex: "vibration",
        $options: "i"
      }
    }
  },
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    condition: 1,
    observations: 1
  }
);


// ============================================================
// 11. UPDATE AN INSPECTION DOCUMENT
// Purpose: Add a further recommendation to INS-002 without
// replacing the existing recommendations.
//
// $addToSet prevents the same recommendation from being added
// more than once.
// ============================================================

db.equipment_inspections.updateOne(
  {
    inspection_id: "INS-002"
  },
  {
    $addToSet: {
      recommendations:
        "Review compressor vibration after corrective maintenance"
    }
  }
);


// ============================================================
// 12. VERIFY THE INSPECTION UPDATE
// Purpose: Confirm that the recommendation was added.
// ============================================================

db.equipment_inspections.find(
  {
    inspection_id: "INS-002"
  },
  {
    _id: 0,
    inspection_id: 1,
    "equipment.equipment_name": 1,
    condition: 1,
    recommendations: 1
  }
);


// ============================================================
// 13. AGGREGATE INSPECTIONS BY EQUIPMENT TYPE
// Purpose: Count inspections and Attention Required conditions
// for each equipment type.
// ============================================================

db.equipment_inspections.aggregate([
  {
    $group: {
      _id: "$equipment.equipment_type",
      total_inspections: {
        $sum: 1
      },
      attention_required_count: {
        $sum: {
          $cond: [
            {
              $eq: [
                "$condition",
                "Attention Required"
              ]
            },
            1,
            0
          ]
        }
      }
    }
  },
  {
    $sort: {
      total_inspections: -1,
      _id: 1
    }
  }
]);


// ============================================================
// 14. AGGREGATE INSPECTIONS BY CONDITION
// Purpose: Summarise inspection documents by condition.
// Expected result:
// Attention Required = 4
// Satisfactory = 4
// ============================================================

db.equipment_inspections.aggregate([
  {
    $group: {
      _id: "$condition",
      inspection_count: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      _id: 1
    }
  }
]);


// ============================================================
// 15. AGGREGATE INSPECTIONS BY ASSET
// Purpose: Summarise inspections and Attention Required
// conditions by operational asset.
// ============================================================

db.equipment_inspections.aggregate([
  {
    $group: {
      _id: {
        asset_id: "$asset.asset_id",
        asset_name: "$asset.asset_name"
      },
      total_inspections: {
        $sum: 1
      },
      attention_required_count: {
        $sum: {
          $cond: [
            {
              $eq: [
                "$condition",
                "Attention Required"
              ]
            },
            1,
            0
          ]
        }
      }
    }
  },
  {
    $sort: {
      "_id.asset_id": 1
    }
  }
]);
