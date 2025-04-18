import * from getOrder::message
// This transform is utilized both in the Get Order Summary (singular) 
// and Get Order Summaries as both are performing the same action to build the query.

%dw 2.0
var orderIds = vars.sfOrderResponse.Id joinBy "', '"

output application/json
---
"SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name FROM FulfillmentOrderLineItem WHERE FulfillmentOrder.OrderSummaryId IN ('" ++ orderIds ++ "')"