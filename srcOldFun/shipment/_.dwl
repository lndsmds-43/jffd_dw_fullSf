%dw 2.0 
import * from zRetrieve
var payload = get("shipment", "payload")
var vars = {
    sfFulfillmentOrders : get("shipment", "sfFulfillmentOrders"),
    nsShipment : get("shipment", "nsShipment")
}

var sfFulfillmentOrders = [
    {
        "sfFulfillmentId": "0a3VF0000002xX3YAI",
        "nsFulfillmentId": "23057239",
        "sfOrderId": "1OsVF000000xYX70AM",
        "sfAccountId": "001VF00000J0qoWYAR",
        "sfLocationId": "131VF000000yHhBYAU",
        "shipTo": {
            "name": "Bella Ponce",
            "address": {
                "line1": "1790 Grande Boulevard Southeast",
                "city": "Rio Rancho",
                "state": "NM",
                "stateText": "New Mexico",
                "postalCode": "87124",
                "countryCode": "US",
                "countryText": "United States"
            }
        }
    }
]

var nsShipment={
    "sfOrderId": "0a3VF0000002xX3YAI",
    "nsFulfillmentId": "23057239",
    "nsShipmentId": "23205472",
    "trackingNumber": "880225896544"
  }


---
sfFulfillmentOrders filter ($.nsFulfillmentId == nsShipment.nsFulfillmentId) map (
    $
    ++ 
    {
    	nsShipmentId: nsShipment.nsShipmentId,
    	trackingNumber: nsShipment.trackingNumber,
    	DeliveryMethodId: "Mule::p('ns.shipment.DeliveryMethodId')",
		Status: "Mule::p('ns.shipment.Status')"
	}
)
/*
sfFulfillmentOrders map ((item, index) -> {
	FulfillmentOrderId: item.Id,
	NS_Item_Fulfillment_ID__c: item.if_id,
	OrderSummaryId: item.OrderSummary.Id,
	TrackingNumber: item.package_tracking_number,
	Account__c: item.OrderSummary.AccountId,
	ShipToName: item.FulfilledToName,
	ShipToCity: item.FulfilledToCity,
	ShipToCountry: item.FulfilledToCountry,
	ShipToCountryCode: item.FulfilledToCountryCode,
	ShipToState: item.FulfilledToState,
	ShipToStateCode: item.FulfilledToStateCode,
	ShipToPostalCode: item.FulfilledToPostalCode,
	ShipToStreet: item.FulfilledToStreet,
	DeliveryMethodId: Mule::p('ns.shipment.DeliveryMethodId'),
	Status: Mule::p('ns.shipment.Status')
})
*/