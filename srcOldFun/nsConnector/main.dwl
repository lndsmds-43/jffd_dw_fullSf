%dw 2.0
//import vars from nsConnector::vars

//var itemFulfillment = vars.getItemFulfillmentResponse.getResponse.readResponse.record

var vars = {
    itemFulfillmentId : "23061853",
    shippingCost : "20.00"
}
//////
/*
output application/xml
ns ns0 urn:messages.platform.webservices.netsuite.com
ns ns01 urn:sales.transactions.webservices.netsuite.com
ns ns02 urn:core.platform.webservices.netsuite.com
---
ns0#update: {
	ns0#record @(
        'xmlns:ns01': ns01,
        xsi#'type' : 'ns01:ItemFulfillment',
        internalId: vars.itemFulfillmentId
    ): {
        ns01#shippingCost: vars.shippingCost
    }
}
*/

%dw 2.0

output application/xml
ns ns0  urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:relationships.lists.webservices.netsuite.com
ns ns02 urn:core.platform.webservices.netsuite.com
ns ns03 urn:common.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
---
ns0#updateList: {
	(payload map(
		(item, index) -> ns0#record @(internalId: item.internalId, "xmlns:ns01": ns01, xsi#"type" : "ns01:" ++ item.'type') : {
		(item.updateList mapObject((value, key) -> {
			(key) : value
		}))
	}))
}