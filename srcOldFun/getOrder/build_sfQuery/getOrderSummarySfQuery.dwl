import * from getOrder::message
%dw 2.0
output application/json
---
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
WHERE Id = '" ++ vars.orderSummaryId ++ "'"