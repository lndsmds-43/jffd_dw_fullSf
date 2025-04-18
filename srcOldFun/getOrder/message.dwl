%dw 2.0
import * from modules::retrieve
var attributes = get("src\main\dw\getOrder\attributes")

var vFolder = "getOrder/vars"
var vars = {
    orderSummaryId : get(vFolder, "orderSummaryId"),
    getOrderSummarySfQuery : get(vFolder, "getOrderSummarySfQuery"),
    sfOrderResponse: get (vFolder, "sfOrderResponse"),
    getFulfillmentOrderLineItemsQuery: get(vFolder, "getFulfillmentOrderLineItemsQuery"),
    sfFulfillmentOrderLineItemsResponse: get(vFolder, "sfFulfillmentOrderLineItemsResponse"),
    itemLocations: get(vFolder, "itemLocations"),
    validOrders: get(vFolder, "validOrders")
}