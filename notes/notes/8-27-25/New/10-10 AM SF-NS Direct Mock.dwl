// 10:10 AM SF-NS Direct Mock from past

%dw 2.0 output application/json

//fun itemSummaries(order) = order.OrderItemSummaries filter ($.)

// fun itemAdjustment(OrderItemSummaryId) =  (orderItemSummaryAdjustments[?$.OrderItemSummaryId == OrderItemSummaryId] default [] map ((item, index) ->{


//    order.OrderItemSummaries filter !($.Name contains "Shipping"),
//    order.OrderItemSummaries[?!($.Name contains "Shipping")],
//    itemSummaries(order),
fun itemSummaries(order) = order.OrderItemSummaries filter !($.Name contains "Shipping")
fun shippingSummaries(order) = order.OrderItemSummaries filter ($.Name contains "Shipping")

fun itemSummary(item) = [{
    "item" : {
        id: item.NS_Item_ID__c,
        refName : item.Name
    },
    quantity: item.QuantityNetOrdered,
    rate: item.UnitPrice,
    location: "location"
}]

fun itemAdjustments(order, item) = 
order.OrderItemAdjustmentLineItemSummaries filter ($.OrderItemSummaryId == item.Id)
map ((adjustment) -> {
    item: {
        id: adjustment.AdjustmentCause.NS_Item_ID__c,
        refName : adjustment.OriginalOrderItemAdjustmentLineItem.Name
    },
    itemType: {
        id: "Discount",
        refName: "Discount"
    },
    price: {
        id: "-1"
    },
    rate: adjustment.TotalAmtWithTax
})

fun itemTax(item) = [{
    item: {
        "id" : "p('ns.taxItemId')"
    },
    amount: item.TotalTaxAmount,
    rate: item.TotalTaxAmount
}]
---
payload map ((order) -> 
[
    {
        "items" : (
            itemSummaries(order) flatMap (item) -> 
                itemSummary(item) ++ itemAdjustments(order, item) ++ itemTax(item))
            ++ 
            (shippingSummaries(order) flatMap (shipping) ->
                itemTax(shipping))
    }
])