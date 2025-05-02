For each order - using their id

SELECT Id, FulfilledToPhone, FulfilledToEmailAddress, FulfilledFromLocationId, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode , OrderSummary.id, OrderSummary.OrderNumber, OrderSummary.AccountId, OrderSummary.BillingStreet, OrderSummary.BillingPostalCode, OrderSummary.BillingState, OrderSummary.BillingStateCode, OrderSummary.BillingCity, OrderSummary.BillingCountry, OrderSummary.BillingCountryCode, OrderSummary.CreatedDate, Account.Id, Account.Name, Account.Phone, Account.PersonEmail 
FROM FulfillmentOrder 
WHERE OrderSummaryId = id,
"referenceId": "fulfillmentOrderResponse"
}, 

{
SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c 
FROM OrderItemSummary 
WHERE Status IN ('ALLOCATED', 'FULFILLED') AND OrderSummaryId = id, 
	"referenceId": "orderItemSummaryResponse"
}, 

{
SELECT Id, Name, TotalTaxAmount, QuantityNetOrdered, TotalLineAmount 
FROM OrderItemSummary where (Name='Shipping - Frozen' OR Name='Shipping') AND OrderSummaryId = id, 
	"referenceId": "shippingCost"
}, 
{
SELECT id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name, typeof AdjustmentCause when Promotion then NS_Item_ID__c end, typeof AdjustmentCause when Promotion then id end, typeof AdjustmentCause when Promotion then Name end from OrderItemAdjustmentLineSummary where OrderSummaryId = id, 
	"referenceId": "orderItemSummaryAdjustments"

}, 
{
	"method": "GET", 

	SELECT OrderItemSummaryId, FulfillmentOrderId, FulfillmentOrder.FulfilledFromLocation.id, FulfillmentOrder.FulfilledFromLocation.Name FROM FulfillmentOrderLineItem where FulfillmentOrder.OrderSummaryId = id, 
	"referenceId": "fulfillmentOrderLineItemResponse"
}]
}