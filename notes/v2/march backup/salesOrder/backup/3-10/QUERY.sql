SELECT Id, Status, TotalDeliveryAmount, OrderNumber, BillingStreet, BillingPostalCode, BillingState, BillingStateCode, BillingCity, BillingCountry, BillingCountryCode, CreatedDate, batchId__c,
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
WHERE NS_Sales_Order_ID__c = null
  AND Status IN ('Assigned to Store', 'Fulfilled by Store', 'Approved') 
  AND CreatedDate > 2024-06-01T01:24:51.000+0000 
  AND LastModifiedDate = LAST_N_DAYS:30