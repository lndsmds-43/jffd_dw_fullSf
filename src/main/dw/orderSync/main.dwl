%dw 2.0
output application/json
payload = [
    ""
]
---
payload.message map ((update) ->
{
    "sfShipmentId" : update.custom_fields."SF Shipment Record IntID" default "",
    "nsShipmentId" : update.custom_fields."NetSuite IF Int ID" default "",
    "status" : update.subtag_message,
    "trackingNumber" : update.tracking_number
}
)