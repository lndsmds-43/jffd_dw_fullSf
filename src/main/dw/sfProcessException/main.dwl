%dw 2.0
//import * from sfProcessException::orderSummary
import * from modules::sfFunctions
import sfProcessException::orderSummary as orderSummary
import sfProcessException::exception as exception
//import sfProcessException::detailedException as detailedException

//var orderSummaryResponse = getRecords(sfProcessException::orderSummary::response)
//var exceptionResponse = getRecords(sfProcessException::exception::response)
//var exceptionByOrderResponse = getRecords(
//    sfProcessException::exceptionByOrder::response
//)

var queryAllResponse = 
{
  "status": 0,
  "result": {
    "records": [
      {
        "attributes": {
          "type": "ProcessException",
          "url": "/services/data/v63.0/sobjects/ProcessException/2PeVF000000CmDl0AK"
        },
        "Id": "2PeVF000000CmDl0AK",
        "OwnerId": "005VF00000EXEscYAH",
        "IsDeleted": false,
        "ProcessExceptionNumber": "PE-00059512",
        "CreatedDate": "2025-04-15T19:52:36.000+0000",
        "CreatedById": "005VF00000EXEscYAH",
        "LastModifiedDate": "2025-04-18T21:38:59.000+0000",
        "LastModifiedById": "005VF00000EYaFzYAL",
        "SystemModstamp": "2025-04-18T21:38:59.000+0000",
        "LastViewedDate": "2025-04-18T21:39:00.000+0000",
        "LastReferencedDate": "2025-04-18T21:39:00.000+0000",
        "AttachedToId": "0bMVF000000Cfgw2AC",
        "Message": "Mule Flagged Invalid Order",
        "StatusCategory": "RESOLVED",
        "Status": "Resolved",
        "Category": "Order Activation",
        "Severity": "High",
        "Priority": "Low",
        "CaseId": null,
        "OrderSummaryId": "1OsVF000000xQg20AE",
        "ExternalReference": "ExternalRefID",
        "SeverityCategory": "HIGH",
        "Description": "The following payment doesn't have a batch id 0bMVF000000Cfgw2AC"
      }
    ],
    "totalSize": 1,
    "done": true
  },
  "warnings": []
}

output text/plain ---
executable(sfProcessException::resolved::query)

// output application/json
// ---
// sfProcessException::detailedException::response
// groupBy $.OrderSummaryId