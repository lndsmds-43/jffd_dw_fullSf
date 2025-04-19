var query = 
"SELECT AttachedToId, Category, Description, ExternalReference, 
    Id, IsDeleted, LastModifiedDate, Message, OrderSummaryId,
    Priority, Severity, SeverityCategory, Status, StatusCategory
FROM ProcessException 
WHERE OrderSummaryId IN (SELECT Id FROM OrderSummary WHERE ActiveProcessExceptionCount = 0)"


var response =
[
  {
    "attributes": {
      "type": "ProcessException",
      "url": "/services/data/v62.0/sobjects/ProcessException/2PeVF000000CmDl0AK"
    },
    "AttachedToId": "0bMVF000000Cfgw2AC",
    "Description": "The following payment doesn't have a batch id 0bMVF000000Cfgw2AC",
    "ExternalReference": "ExternalRefID",
    "Id": "2PeVF000000CmDl0AK",
    "IsDeleted": false,
    "LastModifiedDate": "2025-04-18T21:38:59.000+0000",
    "Message": "Mule Flagged Invalid Order",
    "OrderSummaryId": "1OsVF000000xQg20AE",
    "Priority": "Low",
    "Severity": "High",
    "SeverityCategory": "HIGH",
    "Status": "Resolved",
    "StatusCategory": "RESOLVED",
    "OrderSummary": {
      "attributes": {
        "type": "OrderSummary",
        "url": "/services/data/v62.0/sobjects/OrderSummary/1OsVF000000xQg20AE"
      },
      "ActiveProcessExceptionCount": 0
    }
  },
  {
    "attributes": {
      "type": "ProcessException",
      "url": "/services/data/v62.0/sobjects/ProcessException/2PeVF000000CmVV0A0"
    },
    "AttachedToId": "0bMVF000000Cfgw2AC",
    "Description": "4-18-2025-1.0.0",
    "ExternalReference": "ExternalRefID",
    "Id": "2PeVF000000CmVV0A0",
    "IsDeleted": false,
    "LastModifiedDate": "2025-04-19T01:12:41.000+0000",
    "Message": "Mule Flagged Invalid Order",
    "OrderSummaryId": "1OsVF000000xQg20AE",
    "Priority": "Low",
    "Severity": "High",
    "SeverityCategory": "HIGH",
    "Status": "Resolved",
    "StatusCategory": "RESOLVED",
    "OrderSummary": {
      "attributes": {
        "type": "OrderSummary",
        "url": "/services/data/v62.0/sobjects/OrderSummary/1OsVF000000xQg20AE"
      },
      "ActiveProcessExceptionCount": 0
    }
  },
  {
    "attributes": {
      "type": "ProcessException",
      "url": "/services/data/v62.0/sobjects/ProcessException/2PeVF000000CmX70AK"
    },
    "AttachedToId": "1OsVF000000xQg20AE",
    "Description": "4-18-2025-1.0.0",
    "ExternalReference": "ExternalRefID",
    "Id": "2PeVF000000CmX70AK",
    "IsDeleted": false,
    "LastModifiedDate": "2025-04-19T01:12:58.000+0000",
    "Message": "Mule Flagged Invalid Order",
    "OrderSummaryId": "1OsVF000000xQg20AE",
    "Priority": "Low",
    "Severity": "High",
    "SeverityCategory": "HIGH",
    "Status": "Resolved",
    "StatusCategory": "RESOLVED",
    "OrderSummary": {
      "attributes": {
        "type": "OrderSummary",
        "url": "/services/data/v62.0/sobjects/OrderSummary/1OsVF000000xQg20AE"
      },
      "ActiveProcessExceptionCount": 0
    }
  },
  {
    "attributes": {
      "type": "ProcessException",
      "url": "/services/data/v62.0/sobjects/ProcessException/2PeVF000000CmYj0AK"
    },
    "AttachedToId": "1OsVF000000xQg20AE",
    "Description": "4-18-2025-1.0.0",
    "ExternalReference": "0bMVF000000Cfgw2AC",
    "Id": "2PeVF000000CmYj0AK",
    "IsDeleted": false,
    "LastModifiedDate": "2025-04-18T21:39:25.000+0000",
    "Message": "Mule Flagged Invalid Order",
    "OrderSummaryId": "1OsVF000000xQg20AE",
    "Priority": "Low",
    "Severity": "High",
    "SeverityCategory": "HIGH",
    "Status": "Resolved",
    "StatusCategory": "RESOLVED",
    "OrderSummary": {
      "attributes": {
        "type": "OrderSummary",
        "url": "/services/data/v62.0/sobjects/OrderSummary/1OsVF000000xQg20AE"
      },
      "ActiveProcessExceptionCount": 0
    }
  }
]