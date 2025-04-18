import * from modules::retrieve
var x = "y"

var vars = {   
    purchaseOrder : get("buildMessage", "purchaseOrder"),
    shipment : get("buildMessage", "shipment"),
    filePurchase : getByRelative("src\main\dw\buildMessage\purchaseOrder.json")
}