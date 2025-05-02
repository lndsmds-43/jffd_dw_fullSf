Select extra information needed to create a SF Shipment from NS
"SELECT 
Id, --- $.fulfillments.sfFulfillmentId
OrderSummary.Id, --- $.header.sfOrderId
OrderSummary.AccountId, --- $.header.sfAccountId (New)
FulfilledFromLocationId, --- $.fulfillments.sfLocationId
FulfilledToStreet, --- $.shipTo.address.line1
FulfilledToName, --- $.shipTo.contact.name
NS_Fulfillment_Request_ID__c, --- $.fulfillments.nsFulfillmentId
FulfilledToPostalCode, --- $.shipTo.address.postalCode
FulfilledToState, --- $.shipTo.address.stateText (New ?)
FulfilledToStateCode, --- $.shipTo.address.state
FulfilledToCity, --- $.shipTo.address.city
FulfilledToCountry, --- $.shipTo.address.countryText
FulfilledToCountryCode --- $.shipTo.address.countryCode
FROM FulfillmentOrder
WHERE OrderSummaryId in (" ++ orderSummaryIds ++ ")"


Create Shipment
vars.sfFRRespMapping map ((item, index) -> {
	FulfillmentOrderId: item.Id, --- header.sfFulfillmentId 
	NS_Item_Fulfillment_ID__c: item.if_id, --- header.nsShipmentId (New) {comes from NS query}
	OrderSummaryId: item.OrderSummary.Id, --- header.sfOrderId
	TrackingNumber: item.package_tracking_number, --- header.trackingNumber (New) {comes from NS query}
	Account__c: item.OrderSummary.AccountId, --- header.sfAccountId (New) {sf Query}
	ShipToName: item.FulfilledToName, --- shipTo.address.name
	ShipToCity: item.FulfilledToCity, --- shipTo.address.city
	ShipToCountry: item.FulfilledToCountry, --- shipTo.address.countryText
	ShipToCountryCode: item.FulfilledToCountryCode, --- shipTo.address.countryCode
	ShipToState: item.FulfilledToState, --- shipTo.address.stateText (New) {sf Query}
	ShipToStateCode: item.FulfilledToStateCode, --- shipTo.address.state
	ShipToPostalCode: item.FulfilledToPostalCode, --- shipTo.address.postalCode
	ShipToStreet: item.FulfilledToStreet, --- shipTo.address.line1
	DeliveryMethodId: Mule::p('ns.shipment.DeliveryMethodId'), --- header.sfDeliveryMethodId (New) [static property]
	Status: Mule::p('ns.shipment.Status') --- header.status [static property]
})

Does not have required fields from CDM:
header.orderNumber --- could be adjusted in query by adding OrderSummary.orderNumber
header.orderDate --- If this is truly the order date we can get this from the query OrderSummary.createdDate, but if this is relevant to shipping date it must come from NS I imagine
header.type --- "Order Shipment"?
shipFrom.name 
shipTo.contact.phone
shipTo.contact.email

Relationship
Sales Order (1 -> x) [Fulfillments] (1 -> x) [Shipments]
The order has the general shipTo coming from the first Fulfillment Order (they all have the same destination) but it can have multiple FOs coming from different locations, each which can have multiple shipments associated when I'm looking at the records in SF