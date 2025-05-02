//Search Fullfillment OrderSummary

SELECT Id, OrderSummaryId, OrderSummary.NS_Sales_Order_ID__c from FulfillmentOrder 
WHERE OrderSummaryId ='1OsVF000000109F0AQ' 
LIMIT 5 