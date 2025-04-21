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
.result
.records