%dw 2.0
output application/json
var patchShipmentResponse = 
{
  "id": null,
  "items": [
    {
      "exception": null,
      "message": null,
      "payload": {
        "success": true,
        "id": "0OBVF0000002TfR4AU",
        "errors": [
          
        ]
      },
      "id": "0OBVF0000002TfR4AU",
      "statusCode": null,
      "successful": true
    },
    {
      "exception": null,
      "message": null,
      "payload": {
        "success": true,
        "id": "0OBVF0000002JmX4AU",
        "errors": [
          
        ]
      },
      "id": "0OBVF0000002JmX4AU",
      "statusCode": null,
      "successful": true
    }
  ],
  "successful": true
}
---
patchShipmentResponse.items reduce {
    ($.payload.id) : 
        if ($.payload.success) "Updated successfully"
        else "Failed to update" 
}