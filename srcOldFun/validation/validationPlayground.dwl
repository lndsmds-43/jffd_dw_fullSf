%dw 2.0 output application/json
import * from zRetrieve
var payload = get("validation", "payload")
var vars = {
    itemLocations : get("validation", "itemLocations"),
    sfOrderResponse : get("validation", "sfOrderResponse"),
    sfOrderResponseFull : get("validation", "sfOrderResponseFull"),
    sfOrderErrorTesting: get("validation", "sfOrderErrorTesting")
}

fun isShipping(item) = (["Shipping - Ambient", "Shipping - Frozen"] contains item.Name)
fun getOrderedItemsWithoutLocations(order) = 
    order.OrderItemSummaries filter not isShipping($)
    filter !(namesOf(vars.itemLocations) contains $.Id)

fun getOrderedItemsWithoutNsIds(order) =
    order.OrderItemSummaries filter not isShipping($)
    filter isEmpty($.NS_Item_ID__c)

fun getAdjustmentsWithoutNsIds(order) = 
    if (!isEmpty(order.OrderItemAdjustmentLineItemSummaries))
        order.OrderItemAdjustmentLineItemSummaries
             filter (isEmpty($.AdjustmentCause.NS_Item_ID__c))
    else []

fun hasFulfillments(order) = sizeOf(isEmpty(order.FulfillmentOrders)) > 0
fun hasShippingCharges(order) = sizeOf(order.OrderItemSummaries filter isShipping($)) > 0
fun hasOrderedItems(order) = sizeOf(order.OrderItemSummaries filter not isShipping($)) > 0
fun itemsHaveValidLocations(order) = isEmpty(getOrderedItemsWithoutLocations(order))
fun itemsHaveNsIds(order) = isEmpty(getOrderedItemsWithoutNsIds(order))
fun adjustmentsHaveNsIds(order) = isEmpty(getAdjustmentsWithoutNsIds(order))
fun isValidOrder(order) =
    //hasFulfillments(order) and hasShippingCharges(order) and hasOrderedItems(order) 
    //and itemsHaveValidLocations(order) and itemsHaveNsIds(order) and 
    adjustmentsHaveNsIds(order)
---

{
    "validOrders" : vars.sfOrderResponse filter (isValidOrder($)),
    "invalidOrders" : vars.sfOrderResponse filter not (isValidOrder($))
        map ( (order) ->
        {
            "Validation Failure" : "Validation failed and this order will not be sent to be synced with NetSuite",
            "sfOrderId" : order.Id,
            "orderNumber" : order.OrderNumber,
            ("Fulfillments error" : "This order has no fulfillments") if (!hasFulfillments(order)),
            ("Shipping error" : "This order does not have any shipping charges") if (!hasShippingCharges(order)),
            ("Line Items error" : "The order does not have any ordered items") if (!hasOrderedItems(order)),
            ("Line Items error" : "The following items do not have location data: " ++ 
                (getOrderedItemsWithoutLocations(order) map ((item) ->
                    item.Id ++ " - " ++ item.Name) joinBy  ", ")) 
            	if (!itemsHaveValidLocations(order)),
            ("Line Items error" : "The following items do not have nsIds: " ++ 
                (getOrderedItemsWithoutNsIds(order) map ((item) ->
                    item.Id ++ " - " ++ item.Name) joinBy  ", "))
            	if (!itemsHaveNsIds(order)),
			("Adjustments error" :  "The following adjustments do not have adjustment causes with nsIds: " ++ 
                (getAdjustmentsWithoutNsIds(order) map ((adjustment) ->
                    "$(adjustment.Id) - $(adjustment.Name)") joinBy ", "))
                if (!adjustmentsHaveNsIds((order)))
        } )
}