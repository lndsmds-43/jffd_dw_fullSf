%dw 2.0 
import * from modules::sfFunctions
//import * from patchShipments::transforms
//import * from patchShipments::vars

var payload =
[
    {
        "nsShipmentId" : "15373616",
        "status" : "Shipped"
    },
    {
        "nsShipmentId" : "23063757",
        "status" : "Shipped"
    }
]

fun run_nsShipmentIds(payload, vars) = do {
payload.nsShipmentId
}

var nsShipmentIds = run_nsShipmentIds(payload, {})

fun run_getShipmentsRequestMessage(payload, vars) = do {
"SELECT Id, NS_Item_Fulfillment_ID__C, OrderSummaryId FROM Shipment WHERE NS_Item_Fulfillment_ID__c IN ('$(vars.nsShipmentIds joinBy "', '")')"
}

var getShipmentsRequestMessage = run_getShipmentsRequestMessage(payload, {
    nsShipmentIds : nsShipmentIds
})

var getShipmentsResponse = {
  "status": 0,
  "result": {
    "records": [
      {
        "attributes": {
          "type": "Shipment",
          "url": "/services/data/v63.0/sobjects/Shipment/0OBVF0000002TfR4AU"
        },
        "Id": "0OBVF0000002TfR4AU",
        "NS_Item_Fulfillment_ID__c": "15373616",
        "OrderSummaryId": "1OsVF000000xYX70AM"
      },
      {
        "attributes": {
          "type": "Shipment",
          "url": "/services/data/v63.0/sobjects/Shipment/0OBVF0000002UEv4AM"
        },
        "Id": "0OBVF0000002UEv4AM",
        "NS_Item_Fulfillment_ID__c": "23063757",
        "OrderSummaryId": "1OsVF000000yV2X0AU"
      }
    ],
    "totalSize": 2,
    "done": true
  },
  "warnings": []
}
.result.records

fun run_sfShipmentIds(payload, vars) = do {
    vars.getShipmentsResponse.Id
}

var sfShipmentIds = run_sfShipmentIds(payload, {
    getShipmentsResponse : getShipmentsResponse
})

fun run_patchShipmentsRequestMessage(payload, vars) = do {
vars.sfShipmentIds map {
    Id : $,
    Status: "Shipped"
}
}

var patchShipmentsRequestMessage = run_patchShipmentsRequestMessage(payload, {
    sfShipmentIds : sfShipmentIds
})

// output application/json
// ---
// patchShipmentsRequestMessage

////////////////////////////////////////////
// !!! Update !!! //
// ~~~ CSV ~~~
// var updateMessage = patchShipmentsRequestMessage
// output application/csv
// ---
// updateMessage
//
// ~~~ run ~~~
// var updateFile = "shipments.csv"
// var sobject = "Shipment"
// output text/plain
// ---
// executableUpdate(updateFile, sobject)

// // ~~~ resume ~~~
// var terminalReturn = 
// {
//   "status": 0,
//   "result": {
//     "jobId": "750VF00000EzGnoYAF"
//   },
//   "warnings": []
// }
// output text/plain
// ---
// executableUpdateResume(terminalReturn)

///////////////////////////////////////////
// !!! Query !!! //
var query = getShipmentsRequestMessage
output text/plain
---
modules::sfFunctions::executable(getShipmentsRequestMessage)
// /////////////////////////////////////
