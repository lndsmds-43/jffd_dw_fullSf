%dw 2.0
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
    }
]

var response = [
  {
    "attributes": {
      "type": "Shipment",
      "url": "/services/data/v63.0/sobjects/Shipment/0OBVF0000002TfR4AU"
    },
    "Id": "0OBVF0000002TfR4AU",
    "NS_Item_Fulfillment_ID__c": "15373616",
    "TrackingNumber": "29052024CTEdison"
  }
]
output application/json
---
payload[payload indexWhere $.trackingNumber == 123].status