%dw 2.0
output application/json

var fulfillmentOrder = vars.compQueryRespOrderSummary.fulfillmentOrderResponse
var orderItemSummaryResponse = vars.compQueryRespOrderSummary.orderItemSummaryResponse
var orderItemSummaryAdjustments = vars.compQueryRespOrderSummary.orderItemSummaryAdjustments
var fulfillmentOrderLineItemResponse = vars.compQueryRespOrderSummary.fulfillmentOrderLineItemResponse
fun fetchLocation(val) = 
fulfillmentOrderLineItemResponse.FulfillmentOrder.FulfilledFromLocation 
filter (
	$.Id ==( 
		(fulfillmentOrder filter ($.Id == (
		(fulfillmentOrderLineItemResponse filter ($.OrderItemSummaryId == val.Id)).FulfillmentOrderId[0]
	))).FulfilledFromLocationId[0]
))
fun format(createDate) = createDate as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS"}
var sfCreatedDate = ((format((((fulfillmentOrder.OrderSummary.CreatedDate[0]) replace  "+" with "Z") splitBy  "Z")[0] >> "PST")) as Date) as String
fun itemAdjustment(OrderItemSummaryId) =  (orderItemSummaryAdjustments[?$.OrderItemSummaryId == OrderItemSummaryId] default [] map ((item, index) ->{
        "item" : {
            "id" : item.AdjustmentCause.NS_Item_ID__c,
            "refName" : item.OriginalOrderItemAdjustmentLineItem.Name
        },
        "itemType" : {
            "id" : "Discount",
            "refName" : "Discount"
        },
        "price": {
			"id": "-1"
		},
        "rate" : item.TotalAmtWithTax
    } ))

var shippingCostTax = vars.compQueryRespOrderSummary.shippingCosts
var arr = (shippingCostTax map ((item, index) -> if ( item.TotalTaxAmount as Number > 0 ) {
	"item": {
		"id": p('ns.taxItemId'),
		"refName": item.name
	},
	"amount": item.TotalTaxAmount,
	"rate": item.TotalTaxAmount
} else ""  )) -""

---
{
	"billingAddress": {
		"attention": fulfillmentOrder.Account.Name[0],
		"addr1": fulfillmentOrder.OrderSummary.BillingStreet[0],
		"addressee": fulfillmentOrder.Account.Name[0],
		"city": fulfillmentOrder.OrderSummary.BillingCity[0],
		"country": {
			"id": fulfillmentOrder.OrderSummary.BillingCountryCode[0],
			"refName": fulfillmentOrder.OrderSummary.BillingCountry[0]
		},
		"state": fulfillmentOrder.OrderSummary.BillingStateCode[0],
		"zip": fulfillmentOrder.OrderSummary.BillingPostalCode[0],
		"override": true
	},
	"otherrefnum": fulfillmentOrder.OrderSummary.OrderNumber[0],
	"tranDate": sfCreatedDate,
	"entity": p('ns.entityId'),
//	{
//		"id": p('ns.entityId'),
//		"refName": p('ns.entityRefName')
//	},
	"externalId": fulfillmentOrder.OrderSummary.Id[0],
	"custbody_jffd_ch_order_id": fulfillmentOrder.OrderSummary.Id[0],
	"custbody_jffd_customer_name": fulfillmentOrder.FulfilledToName[0],
	"custbody_jffd_customer_email": fulfillmentOrder.FulfilledToEmailaddress[0],
	"custbody_jffd_customer_phone": fulfillmentOrder.FulfilledToPhone[0
		
		
	] default "",
	"orderStatus": Mule::p('ns.orderStatusId'),
//	{
//		"id": Mule::p('ns.orderStatusId')
//	},
	"shipMethod": Mule::p('ns.shipMethodId'),
//	{
//		"id": Mule::p('ns.shipMethodId'),
//		"refName": Mule::p('ns.shipMethodRefName'),
//	},
	"shippingCost": fulfillmentOrder..TotalDeliveryAmount[0],
// --- remove?	"status": Mule::p('ns.statusId'),
//	{
//		"id": Mule::p('ns.statusId')
//	},
	"shippingAddress": {
		"attention": fulfillmentOrder.FulfilledToName[0],
		"addr1": fulfillmentOrder.FulfilledToStreet[0],
		"addressee": fulfillmentOrder.FulfilledToName[0],
		"city": fulfillmentOrder.FulfilledToCity[0],
		"country": {
			"id": fulfillmentOrder.FulfilledToCountryCode[0],
			"refName": fulfillmentOrder.FulfilledToCountry[0]
		},
		"state": fulfillmentOrder.FulfilledToStateCode[0],
		"zip": fulfillmentOrder.FulfilledToPostalCode[0],
		"override": true
	},
	"custbody_jffd_fr_create_status": p('ns.createFR.id'),
//	{ 
//		"id": p('ns.createFR.id'),
//        "refName": p('ns.createFR.status')
//	},   
	"item": {
		"items": flatten(orderItemSummaryResponse map ((item1, index) ->  if(item1.TotalTaxAmount >0)([{

			"item": item1.NS_Item_ID__c,
//			{
//				"id": item1.NS_Item_ID__c,
//				"refName": item1.Name
//			},
			"quantity": item1.QuantityNetOrdered,
//            "rate": item1.ListPrice,			
			"rate": item1.UnitPrice,
			"location": fetchLocation(item1)[0].Id, 
//			{
//				"id": fetchLocation(item1)[0].Id,
//				"refName": fetchLocation(item1)[0].Name
//			}
		}] ++ itemAdjustment(item1.Id) ++ [{
			"item": p('ns.taxItemId'),
//			{
//				"id": p('ns.taxItemId')
//			},
			"amount": item1.TotalTaxAmount,
			"rate": item1.TotalTaxAmount
		}])
      else ([{
			"item": item1.NS_Item_ID__c,
//			{
//				"id": item1.NS_Item_ID__c,
//				"refName": item1.Name
//			},
			"quantity": item1.QuantityNetOrdered,
//            "rate": item1.ListPrice,			
			"rate": item1.UnitPrice,
			"location": fetchLocation(item1)[0].Id,
//			{
//				"id": fetchLocation(item1)[0].Id,
//				"refName": fetchLocation(item1)[0].Name
//			}
		}] ++ itemAdjustment(item1.Id))
       ))
	}
}