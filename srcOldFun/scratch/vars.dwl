%dw 2.0 output application/json 
import * from modules::retrieve
var x = "y"

var vars = {   
    purchaseOrder : get("buildMessage", "purchaseOrder"),
    shipment : get("buildMessage", "shipment"),
    filePurchase : getByRelative("src\main\dw\buildMessage\purchaseOrder.json"),
    filePurchase2 : get("src\main\dw\buildMessage\purchaseOrder.json")

}
---
vars - "purchaseOrder"