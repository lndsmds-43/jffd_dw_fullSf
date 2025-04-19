var queryAll = 
"SELECT fields(all)
FROM ProcessException
WHERE Id = '2PeVF000000CmDl0AK'"

var query = 
"SELECT Id, ActiveProcessExceptionCount, 
  (SELECT fields(all) 
  FROM ProcessExceptions
  LIMIT 200 ) 
FROM OrderSummary 
WHERE Id = '1OsVF000000xQg20AE'"

var response = 
{
  "status": 0,
  "result": {
    "records": [
      {
        "attributes": {
          "type": "OrderSummary",
          "url": "/services/data/v63.0/sobjects/OrderSummary/1OsVF000000xQg20AE"
        },
        "Id": "1OsVF000000xQg20AE",
        "ActiveProcessExceptionCount": 2,
        "ProcessExceptions": {
          "totalSize": 2,
          "done": true,
          "records": [
            {
              "attributes": {
                "type": "ProcessException",
                "url": "/services/data/v63.0/sobjects/ProcessException/2PeVF000000CmX70AK"
              },
              "Id": "2PeVF000000CmX70AK",
              "OwnerId": "005VF00000EXEscYAH",
              "IsDeleted": false,
              "ProcessExceptionNumber": "PE-00059514",
              "CreatedDate": "2025-04-18T21:35:53.000+0000",
              "CreatedById": "005VF00000EXEscYAH",
              "LastModifiedDate": "2025-04-18T21:35:53.000+0000",
              "LastModifiedById": "005VF00000EXEscYAH",
              "SystemModstamp": "2025-04-18T21:35:53.000+0000",
              "LastViewedDate": null,
              "LastReferencedDate": null,
              "AttachedToId": "1OsVF000000xQg20AE",
              "Message": "Mule Flagged Invalid Order",
              "StatusCategory": "ACTIVE",
              "Status": "New",
              "Category": "Order Activation",
              "Severity": "High",
              "Priority": "Low",
              "CaseId": null,
              "OrderSummaryId": "1OsVF000000xQg20AE",
              "ExternalReference": "ExternalRefID",
              "SeverityCategory": "HIGH",
              "Description": "4-18-2025-1.0.0"
            },
            {
              "attributes": {
                "type": "ProcessException",
                "url": "/services/data/v63.0/sobjects/ProcessException/2PeVF000000CmYj0AK"
              },
              "Id": "2PeVF000000CmYj0AK",
              "OwnerId": "005VF00000EXEscYAH",
              "IsDeleted": false,
              "ProcessExceptionNumber": "PE-00059515",
              "CreatedDate": "2025-04-18T21:36:19.000+0000",
              "CreatedById": "005VF00000EXEscYAH",
              "LastModifiedDate": "2025-04-18T21:39:25.000+0000",
              "LastModifiedById": "005VF00000EYaFzYAL",
              "SystemModstamp": "2025-04-18T21:39:25.000+0000",
              "LastViewedDate": "2025-04-18T21:39:25.000+0000",
              "LastReferencedDate": "2025-04-18T21:39:25.000+0000",
              "AttachedToId": "1OsVF000000xQg20AE",
              "Message": "Mule Flagged Invalid Order",
              "StatusCategory": "RESOLVED",
              "Status": "Resolved",
              "Category": "Order Activation",
              "Severity": "High",
              "Priority": "Low",
              "CaseId": null,
              "OrderSummaryId": "1OsVF000000xQg20AE",
              "ExternalReference": "0bMVF000000Cfgw2AC",
              "SeverityCategory": "HIGH",
              "Description": "4-18-2025-1.0.0"
            }
          ]
        }
      }
    ],
    "totalSize": 1,
    "done": true
  },
  "warnings": []
}
