SELECT Id, FulfilledToPhone, OrderSummary.id, OrderSummary.TotalDeliveryAmount, Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail 
FROM FulfillmentOrder
WHERE OrderSummaryId = '1OsVF000000YL3d0AG'