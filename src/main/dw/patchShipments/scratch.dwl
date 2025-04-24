%dw 2.0
import * from modules::sfFunctions
import * from dw::core::Arrays
var payload = [
    {
        "nsShipmentId" : "123",
        "status" : "Gone",
        "trackingNumber" : "29052024CTEdison"

    },
        {
        "trackingNumber" : 123,
        "sfShipmentId" : "sfId",
        "status" : "Sent"
    },

]

var sfIds = [
    {
        "sfShipmentId" : "abc",
        "nsShipmentId" : "123"
    }
]

var shipmentsWithoutSfIds = payload filter isEmpty($.sfShipmentId)

var vars = {
    shipmentsWithoutSfIds : shipmentsWithoutSfIds
}

var trackingNumbersForQuery = vars.shipmentsWithoutSfIds.trackingNumber joinBy "', '"

var query = 
"SELECT Id, NS_Item_Fulfillment_ID__C, TrackingNumber
FROM Shipment 
WHERE TrackingNumber IN ('$(trackingNumbersForQuery)')"

var response = 
{
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
        "TrackingNumber": "29052024CTEdison"
      }
    ],
    "totalSize": 1,
    "done": true
  },
  "warnings": []
}.result.records

output application/json
---
payload[payload indexWhere $.trackingNumber == 123].status


// users indexWhere (item) -> item startsWith "Jul"

// response map ((shipment) ->
//     {
//         "Id" : shipment.Id,
//         "record" : (payload filter ($.trackingNumber == shipment.TrackingNumber)).status[0]
//     }
// )


// response map ((shipment) ->
// {
//     Id: shipment.Id,
//     Status: (payload filter ($.TrackingNumber == shipment.trackingNumber)).status
//     // Status : payload filter ($.Tracking == payload.TrackingNumber)
// }
// )




////////
// output text/plain
// ---
// executableQuery(query)
/*
payload map ( (nsShipment) ->
    nsShipment ++ 
    (sfShipmentId : (sfIds filter $.nsShipmentId == nsShipment.nsShipmentId)[0].sfShipmentId)
)
*/