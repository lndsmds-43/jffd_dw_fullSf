%dw 2.0
import webhook::message
var message = webhook::message::main(payload : {}).msg
---
[message] map((message) ->
{
    ("sfShipmentId" : message.custom_fields."SF Shipment Record IntID") if (not isEmpty(message.custom_fields."SF Shipment Record IntID")),
    ("nsShipmentId" : message.custom_fields."NetSuite IF Int ID") if (not isEmpty(message.custom_fields."NetSuite IF Int ID")),
    "status" : message.subtag_message,
    "trackingNumber" : message.tracking_number
}
)