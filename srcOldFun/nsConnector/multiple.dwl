%dw 2.0
output application/xml


var payload = [
    {
        "itemFulfillmentId" : "23061853",
        "shippingCost" : "12.34"
    },
    {
        "itemFulfillmentId" : "23063054",
        "shippingCost" : "56.78"
    }
]

ns ns0 urn:messages.platform.webservices.netsuite.com
ns ns01 urn:sales.transactions.webservices.netsuite.com
ns ns02 urn:core.platform.webservices.netsuite.com
ns ns03 urn:common.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
output application/xml
---	
ns0#updateList: {
	(payload map {
        ns0#record @(
            'xmlns:ns01': ns01,
            xsi#"type" : "ns01:ItemFulfillment",
            internalId: $.itemFulfillmentId
        ) 
            : 
        ("shippingCost" : $.shippingCost)
    })
}

/*
ns0#updateList: {
	(payload map( (item) -> 
	ns0#record @(internalId: item.internalId, "xmlns:ns01": ns01, xsi#"type" : "ns01:" ++ item.'type') 
        : 
	("shippingCost" : item.shippingCost)
    ))
}
*/