var query = 
"SELECT COUNT(Id) ExceptionCount, Status, StatusCategory, OrderSummaryId
FROM ProcessException 
WHERE OrderSummaryId IN (SELECT Id FROM OrderSummary )
GROUP BY OrderSummaryId, Status, StatusCategory
ORDER BY OrderSummaryId "

var response = {
  "status": 0,
  "result": {
    "records": [
      {
        "attributes": {
          "type": "AggregateResult"
        },
        "ExceptionCount": 14,
        "Status": "New",
        "StatusCategory": "ACTIVE",
        "OrderSummaryId": "1OsVF000000rCRF0A2"
      },
      {
        "attributes": {
          "type": "AggregateResult"
        },
        "ExceptionCount": 26,
        "Status": "New",
        "StatusCategory": "ACTIVE",
        "OrderSummaryId": "1OsVF000000rVaM0AU"
      },
      {
        "attributes": {
          "type": "AggregateResult"
        },
        "ExceptionCount": 13,
        "Status": "New",
        "StatusCategory": "ACTIVE",
        "OrderSummaryId": "1OsVF000000rXfO0AU"
      },
      {
        "attributes": {
          "type": "AggregateResult"
        },
        "ExceptionCount": 1,
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000rlK90AI"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 1,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000rnLx0AI"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 1,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000sIb50AE"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 1,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000sIuP0AU"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 1,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000sMtB0AU"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 3,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000uCw90AE"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 1,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000x1w90AA"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 9,        
        "Status": "Resolved",       
        "StatusCategory": "RESOLVED",
        "OrderSummaryId": "1OsVF000000x1w90AA"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 2,        
        "Status": "New",
        "StatusCategory": "RESOLVED", 
        "OrderSummaryId": "1OsVF000000xQg20AE"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 2,        
        "Status": "Resolved",       
        "StatusCategory": "RESOLVED",
        "OrderSummaryId": "1OsVF000000xQg20AE"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 5,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000xqaT0AQ"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 1,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000yU9h0AE"
      },
      {
        "attributes": {
          "type": "AggregateResult" 
        },
        "ExceptionCount": 2,        
        "Status": "New",
        "StatusCategory": "ACTIVE", 
        "OrderSummaryId": "1OsVF000000yV2X0AU"
      }
    ],
    "totalSize": 16,
    "done": true
  },
  "warnings": []
}

var groupedExceptions = 
response.result.records
groupBy ($.OrderSummaryId)
mapObject ((ExceptionInfo, OrderSummaryid, index) -> 
    (OrderSummaryid) : ExceptionInfo map {
        "StatusCategory" : $.StatusCategory,
        "ExceptionCount" : $.ExceptionCount
    }
)