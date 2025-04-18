%dw 2.0
import * from modules::Retrieve

var vars = {   
    purchaseOrder : get("buildMessage", "purchaseOrder"),
    shipment : get("buildMessage", "shipment"),
    filePurchase : getByRelative("src\main\dw\buildMessage\purchaseOrder.json")
}

fun buildPurchaseOrderMessage(purchaseOrder) = 
{
    "metadata": {
        "SfOrderId": purchaseOrder.header.sfOrderId,
        "OrderNumber": purchaseOrder.header.orderNumber,
        "OrderDate": purchaseOrder.header.orderDate,
        "MessageType": "Purchase Order",
        "Event": "Pending Creation",
        "Topic": "order-exchange",
        "Channel": "ORDER_SYNC",
        "DateTime": now()
    },
    "message": [purchaseOrder]

}

fun buildShipmentMessage(shipment) =
{
    "metadata": {
        "nsShipmentId": shipment.nsShipmentId,
        "MessageType": "Shipment",
        "Event": "Pending Creation",
        "Topic": "order-exchange",
        "Channel": "ORDER_SYNC",
        "DateTime": now()
    },
    "message": [shipment]

}
output application/json
---
buildPurchaseOrderMessage(vars.filePurchase) 