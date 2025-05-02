%dw 2.0
output application/json
//// Test

var vars = {
    initialPayload : [
  {
    "nsShipmentId": "123",
    "status": "Gone 2.0",
    "trackingNumber": "29052024CTEdison-error"
  },
  {
    "trackingNumber": "9653070370550714",
    "sfShipmentId": "0OBVF0000002JmX4AU-error",
    "status": "Sent 2.0"
  }
],
patchShipmentsResponse : 
{
//   "id": null,
//   "items": [
//     {
//       "exception": null,
//       "message": null,
//       "payload": {
//         "success": true,
//         "id": "0OBVF0000002TfR4AU",
//         "errors": [
          
//         ]
//       },
//       "id": "0OBVF0000002TfR4AU",
//       "statusCode": null,
//       "successful": true
//     },
//     {
//       "exception": null,
//       "message": null,
//       "payload": {
//         "success": true,
//         "id": "0OBVF0000002JmX4AU",
//         "errors": [
          
//         ]
//       },
//       "id": "0OBVF0000002JmX4AU",
//       "statusCode": null,
//       "successful": true
//     }
//   ],
//   "successful": true
// }
// }

        "suppressed": [
          
        ]
      },
      "message": "Shipment ID: id value of incorrect type: 0OBVF0000002JmX4AU-error",
      "payload": {
        "success": false,
        "id": null,
        "errors": [
          {
            "duplicateResult": null,
            "message": "Shipment ID: id value of incorrect type: 0OBVF0000002JmX4AU-error",
            "fields": [
              "Id"
            ],
            "statusCode": "MALFORMED_ID"
          }
        ]
      },
      "id": null,
      "statusCode": "MALFORMED_ID",
      "successful": false
    }
  ],
  "successful": false
}}
---
(vars.patchShipmentsResponse.items filter ($.exception != null))
map ((errorResponse, index) ->
	{
		("Error on updating shipment w/ trackingNumber: " 
			++ vars.initialPayload.trackingNumber[index]
		) 
		: errorResponse.exception.message
	}
) 