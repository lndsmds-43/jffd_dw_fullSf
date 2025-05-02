SELECT Id, FulfilledToPhone, FulfilledFromLocationId, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode , OrderSummary.id, OrderSummary.TotalDeliveryAmount, OrderSummary.OrderNumber, OrderSummary.AccountId, OrderSummary.BillingStreet, OrderSummary.BillingPostalCode, OrderSummary.BillingState, OrderSummary.BillingStateCode, OrderSummary.BillingCity, OrderSummary.BillingCountry, OrderSummary.BillingCountryCode, OrderSummary.CreatedDate,  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail 
FROM FulfillmentOrder
WHERE OrderSummaryId = *id*
"referenceId": "fulfillmentOrderResponse"

SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c 
FROM OrderItemSummary
WHERE Status IN ('ALLOCATED', 'FULFILLED') 
  AND OrderSummaryId= *id*
"referenceId": "orderItemSummaryResponse"

SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name, 
  TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END 
FROM OrderItemAdjustmentLineSummary
WHERE OrderSummaryId = *id*,
"referenceId": "orderItemSummaryAdjustments"

SELECT Id, Name, TotalTaxAmount, QuantityNetOrdered, TotalLineAmount 
FROM OrderItemSummary
WHERE Name IN ('Shipping - Frozen', 'Shipping - Ambient') 
  AND OrderSummaryId= *id*
"referenceId": "shippingCosts"

SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name 
FROM FulfillmentOrderLineItem
WHERE FulfillmentOrder.OrderSummaryId = *id*
"referenceId": "fulfillmentOrderLineItemResponse"


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SELECT Id, FulfilledToPhone, FulfilledFromLocationId, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode , OrderSummary.id, OrderSummary.TotalDeliveryAmount, OrderSummary.OrderNumber, OrderSummary.AccountId, OrderSummary.BillingStreet, OrderSummary.BillingPostalCode, OrderSummary.BillingState, OrderSummary.BillingStateCode, OrderSummary.BillingCity, OrderSummary.BillingCountry, OrderSummary.BillingCountryCode, OrderSummary.CreatedDate,  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail 
FROM FulfillmentOrder
WHERE OrderSummaryId = *id*
"referenceId": "fulfillmentOrderResponse"

SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c, TotalLineAmount
FROM OrderItemSummary
WHERE Status IN ('ALLOCATED', 'FULFILLED') 
  OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')
  AND OrderSummaryId= *id*
"referenceId": "orderItemSummaryResponse"

SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name, 
  TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END 
FROM OrderItemAdjustmentLineSummary
WHERE OrderSummaryId = *id*,
"referenceId": "orderItemSummaryAdjustments"



(SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name FROM FulfillmentOrderLineItems)
WHERE FulfillmentOrder.OrderSummaryId = *id*
"referenceId": "fulfillmentOrderLineItemResponse"

(SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name FROM FulfillmentOrderLineItems)

==================

(SELECT Id, FulfilledToPhone, FulfilledFromLocationId, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode , OrderSummary.id, OrderSummary.TotalDeliveryAmount, OrderSummary.OrderNumber, OrderSummary.AccountId, OrderSummary.BillingStreet, OrderSummary.BillingPostalCode, OrderSummary.BillingState, OrderSummary.BillingStateCode, OrderSummary.BillingCity, OrderSummary.BillingCountry, OrderSummary.BillingCountryCode, OrderSummary.CreatedDate,  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail, (SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name FROM FulfillmentOrderLineItems)
FROM FulfillmentOrders)

SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c, TotalLineAmount
FROM OrderItemSummaries
WHERE Status IN ('ALLOCATED', 'FULFILLED') 
  OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')

SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name, 
  TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END 
FROM OrderItemAdjustmentLineSummaries

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SELECT Id, Status,
  (SELECT Id, FulfilledToPhone, FulfilledFromLocationId, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode , OrderSummary.id, OrderSummary.TotalDeliveryAmount, OrderSummary.OrderNumber, OrderSummary.AccountId, OrderSummary.BillingStreet, OrderSummary.BillingPostalCode, OrderSummary.BillingState, OrderSummary.BillingStateCode, OrderSummary.BillingCity, OrderSummary.BillingCountry, OrderSummary.BillingCountryCode, OrderSummary.CreatedDate,  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail, 
    (SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name FROM FulfillmentOrderLineItems)
  FROM FulfillmentOrders),
  (SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c, TotalLineAmount
  FROM OrderItemSummaries
  WHERE Status IN ('ALLOCATED', 'FULFILLED') 
    OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')),
(SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name, 
    TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END 
  FROM OrderItemAdjustmentLineItemSummaries)
FROM OrderSummary 
WHERE NS_Sales_Order_ID__c = null AND Status IN ('Waiting for Store to Fulfill', 'Assigned to Store', 'Fulfilled by Store', 'Approved') AND CreatedDate > 2024-06-01T01:24:51.000+0000 AND LastModifiedDate > " ++ vars.defaultTimeStamp