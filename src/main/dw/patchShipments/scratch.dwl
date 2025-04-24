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
        "trackingNumber" : "9653070370550714",
        "sfShipmentId" : "0OBVF0000002JmX4AU",
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

var getShipmentsResponse = 
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
      },
      {
        "attributes": {
          "type": "Shipment",
          "url": "/services/data/v63.0/sobjects/Shipment/0OBVF0000002TfR4AU"
        },
        "Id": "0OBVF0000002TfR4AU",
        "NS_Item_Fulfillment_ID__c": "15373616",
        "TrackingNumber": "123"
      }

    ],
    "totalSize": 1,
    "done": true
  },
  "warnings": []
}.result.records

fun whereEquals (array, arrField, obj, objField) = 
    //array[
        array indexWhere array.arrField == obj.objField
    //]

fun bracketIfExists(name, value) = 
    ((name) : value) if (not isEmpty)
output application/json
---
//payload[payload indexWhere $.trackingNumber == 123].status

// payload map ((shipment) ->
//     shipment update {
//         case .sfShipmentId! -> (getShipmentsResponse filter shipment.trackingNumber == $.TrackingNumber)[0].Id
//     }
//)

payload map ((update) ->
{
    Id : (update.sfShipmentId) onNull (getShipmentsResponse filter update.trackingNumber == $.TrackingNumber)[0].Id,
    Status: update.status
}
)
// Update reduction

// payload map ((shipment)  ->
//     shipment update {
//         case .sfShipmentId! -> 
//             (getShipmentsResponse filter shipment.trackingNumber == $.TrackingNumber).Id[0]
// })


// payload map ((update) ->
// {
    
//     Status : update.status,
//     Id : 
//         if (!isEmpty(update.sfShipmentId)) update.sfShipmentId
//         else if (true)
//         (getShipmentsResponse filter (update.trackingNumber == $.TrackingNumber))
//         else null
// }
//)
//  update ++
//  
//)
//




////////////////////////////
// payload map ((update) ->
//     update ++
//     ("sfShipmentId" : getShipmentsResponse[getShipmentsResponse indexWhere $.TrackingNumber == update.trackingNumber].Id) if (isEmpty(update.sfShipmentId))
// )

    // if (isEmpty(shipment.sfShipmentId))
    // shipment update {
    //     case sfShipmentId at .sfShipmentId! -> if(sfShipmentId == null) "JOHN" else upper(name)
    // }


// users indexWhere (item) -> item startsWith "Jul"

// getShipmentsResponse map ((shipment) ->
//     {
//         "Id" : shipment.Id,
//         "record" : (payload filter ($.trackingNumber == shipment.TrackingNumber)).status[0]
//     }
// )


// getShipmentsResponse map ((shipment) ->
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