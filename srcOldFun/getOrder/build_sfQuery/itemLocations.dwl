import * from getOrder::message
// This transform is utilized both in the Get Order Summary (singular) 
// and Get Order Summaries as both are performing the same action to build the itemToWareHouseIdMapping variable.

%dw 2.0
output application/json
---
vars.sfFulfillmentOrderLineItemsResponse map {
    ($.OrderItemSummaryId) : {
        "sfLocationId" : $.FulfillmentOrder.FulfilledFromLocation.Id,
        "description" : $.FulfillmentOrder.FulfilledFromLocation.Name
    }
} reduce ($$ ++ $)