%dw 2.0
import webhook::message
var message = webhook::message::main(payload : {}).msg
---
{
    "sfOrderId" : message.custom_fields."SF Order Summary IntID",
    "sfShipmentId" : message.custom_fields."SF Shipment Record IntID",
    "sfFulfillmentId" : message.custom_fields."OMS fulfilment ID",
    "nsFulfillmentId" : message.custom_fields."Fulfilment Request IntID",
    "nsShipmentId" : message.custom_fields."NetSuite IF Int ID",
    "status" : message.subtag_message,
    "trackingNumber" : message.tracking_number,
    "deliveryMethod" : message.shipment_type
}