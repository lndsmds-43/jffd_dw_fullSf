import * from modules::retrieve

var attributes = {
    "uriParams" : {
        "id" : 123456789
    }
}

var orderSummaryId = attributes.uriParams.'id'

var getOrderSummarySfQuery = do 
{ // <<<<
"SELECT Id, Status, TotalDeliveryAmount, OrderNumber, BillingStreet, BillingPostalCode, BillingState, BillingStateCode, BillingCity, BillingCountry, BillingCountryCode, CreatedDate, batchId__c,
  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail,
  (SELECT Id, FulfilledToPhone, FulfilledToEmailAddress, FulfilledFromLocation.Id, FulfilledFromLocation.Name, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode
  FROM FulfillmentOrders
  ),
  (SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c, TotalLineAmount
  FROM OrderItemSummaries
  WHERE Status IN ('ALLOCATED', 'FULFILLED') 
    OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')
  ),
  (SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name, 
    TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END 
  FROM OrderItemAdjustmentLineItemSummaries
  ),
  (SELECT Id, Method, CapturedAmount 
  FROM OrderPaymentSummaries
  WHERE NS_Customer_Deposit_ID__c = null 
    AND CapturedAmount > 0
  )
FROM OrderSummary 
WHERE Id = '" ++ orderSummaryId ++ "'"
} // >>>>

var sfOrderResponse = get("getOrder/vars", "sfOrderResponse")

var getFulfillmentOrderLineItemsQuery = do 
{ // <<<<
var orderIds = sfOrderResponse.Id joinBy "', '"
---
"SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name FROM FulfillmentOrderLineItem WHERE FulfillmentOrder.OrderSummaryId IN ('" ++ orderIds ++ "')"

} // >>>>

var sfFulfillmentOrderLineItemsResponse = get("getOrder/vars", "sfFulfillmentOrderLineItemsResponse")

var itemLocations = do
{ 
// <<<<
sfFulfillmentOrderLineItemsResponse map {
    ($.OrderItemSummaryId) : {
        "sfLocationId" : $.FulfillmentOrder.FulfilledFromLocation.Id,
        "description" : $.FulfillmentOrder.FulfilledFromLocation.Name
    }
} reduce ($$ ++ $)
// >>>>
} 

var validOrders = sfOrderResponse

var payload = do
{  
// <<<<
fun itemSummaries(order) = order.OrderItemSummaries filter not ($.Name contains "Shipping") default []

fun shippingSummaries(order) = order.OrderItemSummaries filter ($.Name contains "Shipping") default []

fun itemSummary(item) = 
    [{
        "quantity": item.QuantityNetOrdered as Number,
        "unitPrice" : item.UnitPrice as Number,
        "nsItemId": item.NS_Item_ID__c,
        "description" : item.Name,
        "location": {
            "sfLocationId" : itemLocations[item.Id].sfLocationId,
            "description": itemLocations[item.Id].description
        },
        "itemType": "item"
    }]

fun itemDiscounts(order, item) = 
    order.OrderItemAdjustmentLineItemSummaries filter ($.OrderItemSummaryId == item.Id)
    map ((adjustment) -> {
        "nsItemId": adjustment.AdjustmentCause.NS_Item_ID__c,
        "description": adjustment.OriginalOrderItemAdjustmentLineItem.Name,
        "unitPrice": adjustment.TotalAmtWithTax as Number,
        "itemType": "discount"
    }) default []

fun itemTax(item) = 
    if (item.TotalTaxAmount > 0) 
        [{
            "taxAmount": item.TotalTaxAmount as Number,
            "unitPrice": item.TotalTaxAmount as Number,
            "itemType": "tax"
        }]
    else []

fun otherDiscounts(order) = 
    order.OrderItemAdjustmentLineItemSummaries filter not (itemSummaries(order).Id contains $.OrderItemSummaryId)
    map ((adjustment) -> {
        "nsItemId": adjustment.AdjustmentCause.NS_Item_ID__c,
        "description": adjustment.OriginalOrderItemAdjustmentLineItem.Name,
        "unitPrice": adjustment.TotalAmtWithTax as Number,
        "itemType": "discount"
    }) default []

---
validOrders map ((order) -> 
{
    "header": {
        "orderNumber": order.OrderNumber,
        "sfOrderId": order.Id,
        "orderDate": (order.CreatedDate >> "PST") as Date,
        "type": "Purchase Order",
        "status": order.Status,
    },
    "shipTo" : {
        "name": order.FulfillmentOrders[0].FulfilledToName,
        "address": {
            "line1": order.FulfillmentOrders[0].FulfilledToStreet,
            "city": order.FulfillmentOrders[0].FulfilledToCity,
            "state": order.FulfillmentOrders[0].FulfilledToStateCode,
            "postalCode": order.FulfillmentOrders[0].FulfilledToPostalCode,
            "countryCode": order.FulfillmentOrders[0].FulfilledToCountryCode,
            "countryText": order.FulfillmentOrders[0].FulfilledToCountry
        },
        "contact": {
            "name": order.FulfillmentOrders[0].FulfilledToName,
            "phone": order.FulfillmentOrders[0].FulfilledToPhone,
            "email": order.FulfillmentOrders[0].FulfilledToEmailAddress
        }
    },
    "billTo" : {
        "name": order.Account.Name,
        "address" : {
            "line1": order.BillingStreet,
            "city": order.BillingCity,
            "state": order.BillingStateCode,
            "postalCode": order.BillingPostalCode,
            "countryCode": order.BillingCountryCode,
            "countryText": order.BillingCountry
        }
    },
    "shippingInstructions" : [
        {
            "cost": order.TotalDeliveryAmount as Number
        }
    ],
    "payments" : order.OrderPaymentSummaries map (payment) ->{
        "amount": payment.CapturedAmount as Number,
        "batchId": order.batchId__c,
        "method": payment.Method,
        "sfPaymentId": payment.Id
    },
    "lineItems": (
            (itemSummaries(order) flatMap (item) -> 
                itemSummary(item) ++ itemDiscounts(order, item) ++ itemTax(item))
            ++ 
            (shippingSummaries(order) flatMap (shipping) ->
                itemTax(shipping))
            ++
            otherDiscounts(order)
    ),
    "fulfillments": order.FulfillmentOrders map {
        "sfFulfillmentId": $.Id,
        "location": {
            "sfLocationId": $.FulfilledFromLocation.Id,
            "description": $.FulfilledFromLocation.Name
        }
    }
}
)
// >>>>
}

var payload2 = get("getOrer/build_sfQuery", "payload2.dwl")
output application/json
---
payload