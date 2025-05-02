SELECT Id, Status, NS_Sales_Order_ID__c, id, TotalDeliveryAmount, OrderNumber, AccountId, BillingStreet, BillingPostalCode, BillingState, BillingStateCode, BillingCity, BillingCountry, BillingCountryCode, CreatedDate,
  (SELECT Id, FulfilledToPhone, FulfilledFromLocationId, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode ,  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail, 
    (SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name 
    FROM FulfillmentOrderLineItems)
  FROM FulfillmentOrders),
  (SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c, TotalLineAmount
  FROM OrderItemSummaries
  WHERE Status IN ('ALLOCATED', 'FULFILLED') 
    OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')),
  (SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name, 
    TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END 
  FROM OrderItemAdjustmentLineItemSummaries)
FROM OrderSummary 
WHERE Id = '1OsVF000000gh6z0AA'
LIMIT 5


id, TotalDeliveryAmount, OrderNumber, AccountId, BillingStreet, BillingPostalCode, BillingState, BillingStateCode, BillingCity, BillingCountry, BillingCountryCode, CreatedDate,