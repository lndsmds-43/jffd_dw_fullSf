import * from getOrder::message
// The response from the SF query is a java array.
// This transform is utilized both in the Get Order Summary (singular) 
// and Get Order Summaries as both are operating off said array.
%dw 2.0

fun itemSummaries(order) = order.OrderItemSummaries filter not ($.Name contains "Shipping") default []

fun shippingSummaries(order) = order.OrderItemSummaries filter ($.Name contains "Shipping") default []

fun itemSummary(item) = 
    [{
        "quantity": item.QuantityNetOrdered as Number,
        "unitPrice" : item.UnitPrice as Number,
        "nsItemId": item.NS_Item_ID__c,
        "description" : item.Name,
        "location": {
            "sfLocationId" : vars.itemLocations[item.Id].sfLocationId,
            "description": vars.itemLocations[item.Id].description
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

output application/json
---
vars.validOrders map ((order) -> 
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