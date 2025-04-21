fun run_getShipmentsRequestMessage(payload, vars) = 
"SELECT Id, NS_Item_Fulfillment_ID__C, OrderSummaryId FROM Shipment WHERE NS_Item_Fulfillment_ID__c IN ('$(vars.nsShipmentIds joinBy "', '")')"

fun run_nsShipmentIds(payload, vars) =
payload.nsShipmentId

fun run_sfShipmentIds(payload, vars) =
vars.getShipmentsResponse.Id