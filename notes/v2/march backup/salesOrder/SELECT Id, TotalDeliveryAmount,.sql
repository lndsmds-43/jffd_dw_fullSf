SELECT Id, TotalDeliveryAmount, 
(Select Id, FulfilledToPhone, FulfillmentOrderLineItem.FulfilledFromLocation.id from FulfillmentOrders),
(SELECT Id, Name FROM OrderItemSummaries WHERE Status IN ('ALLOCATED', 'FULFILLED') OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')),
(SELECT Id, Name FROM OrderItemAdjustmentLineItemSummaries ),

FROM OrderSummary
WHERE Id = '1OsVF000000YL3d0AG'



SELECT Id, TotalDeliveryAmount, 
(Select Id, FulfilledToPhone from FulfillmentOrders),
(SELECT Id, Name FROM OrderItemSummaries WHERE Status IN ('ALLOCATED', 'FULFILLED') OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')),
(SELECT Id, Name FROM OrderItemAdjustmentLineItemSummaries )
(SELECT FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id)
FROM OrderSummary
WHERE Id = '1OsVF000000YL3d0AG'



SELECT Id, TotalDeliveryAmount, 
(Select Id, FulfilledToPhone from FulfillmentOrders),
(SELECT Id, Name FROM OrderItemSummaries WHERE Status IN ('ALLOCATED', 'FULFILLED') OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')),
(SELECT Id, Name FROM OrderItemAdjustmentLineItemSummaries )
FROM OrderSummary
WHERE Id = '1OsVF000000YL3d0AG'
