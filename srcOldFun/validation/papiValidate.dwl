%dw 2.0
output application/json
import * from zRetrieve
var payload = get("validation", "payload")

var purchaseOrder = payload.message[0]
var shippingCost = purchaseOrder.shippingInstructions.cost reduce ($ ++ $$)

var items = purchaseOrder.lineItems filter ($.itemType == "item")
var itemsWithLocations = items filter (!(isEmpty($.location)))
var itemsWithoutLocations = items filter (isEmpty($.location))
var fulfillments = purchaseOrder.fulfillments

var error = 
{
    ("Shipping error" : "This order does not have any shipping costs") if (shippingCost == 0),
    ("Line Items error" : "The order has no valid line items") if (isEmpty(purchaseOrder.lineItems filter ($.itemType == "item"))),
    ("Line Items error" : "The following items do not have location data: " ++ 
        (itemsWithoutLocations.nsItemId joinBy ", ")) if (sizeOf(items) != sizeOf(itemsWithLocations)),
    ("Fulfillments error" : "This order has no fulfillments") if (isEmpty(fulfillments))
}
/*
 pluck ((value, key) -> (key) ++ ": " ++ value) joinBy  "; "
/*
---
if (!isEmpty(error))
    (
    	"Sync Aborted: Salesforce Order " ++ purchaseOrder.header.sfOrderId ++ ": '"
	    	++ purchaseOrder.header.orderNumber ++ "' was not sent to Netsuite due to invalid order information; ")
	    	++ error
else []
*/
---
error