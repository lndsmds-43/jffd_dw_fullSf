SF
GET Orders Ids for null NS Ids

For each
Get all Information for OrderSummary. This can include 
Account,FulfillmentOrders, OrderItemSummaries, OrderItemAdjustmentLineItemSummaries, OrderPayment Summaries

Create a nsSalesOrder from sfSalesOrderSummary 
    -- This uses a restlet to create an nsFulfillmentRequest from the sfFulfillmentOrder information
    -- Because of this we aren't going to be able to currently get the ns ids for the FulfillmentRequests created
Patch SalesOrder w/ newly created nsId

Take the Fulfillment Order for sfOrderSummary,
    -- ask ns for the id of a Fulfillment Request 
For each Fulfillment Order w/ sf Sales Order
get the nsId for Fulfillment Request that matches the sfId for Fulfillment Order
patch it to to sf Fulfillment Order

Something Strange with Location here
SELECT 
so.id AS so_id, // ns Sales Order Id
so.custbody_jffd_ch_order_id AS so_channel_order_id, // sf Sales Order Id stored in ns
fr.id AS fr_id, // ns Fulfillment Request Id
fr.location AS fr_location // location

FROM 
transaction AS so 

INNER JOIN 
fulfillmentRequest AS fr 

ON fr.createdfrom = so.id // ns Sales Order id 
WHERE 
so.id ='" ++ vars.sfOrderSummaryRespMapping.sOId ++"'  // ns Id from Sales Order Query
AND fr.location ='" ++ vars.sfOrderSummaryRespMapping.locId ++"' // location id I'm confused by
// Uses the mapping from Sf warehous to nsWarehouse we did earlier
AND so.recordtype = 'salesorder' // generic
AND so.entity = '13145' // generic
 -- JFFD Web Customer ID; // Uncertain
 ---- I think we still have this id from the earlier first transform though. 

 I also think we only need this if we can't create the FRs ourselves.
 Patch NS with the sf Fulfillment Order id, Patch SF with ns Fulfillment Request Id

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Post create customer deposit ---
 Transform SF payment summary info into single deposit
 Send to NS
 (set ns id for payment summary to pending)
Ask ns for the id of the customer deposit it just made and patch it back to sf


SF
Get Order Ids
Get Order Summary / {Id}

Patch Sales Order
Patch Fulfillment Request
Patch Payment Summary

///

Post Shipment
~~~~~~~~~~~~~~~
NS
Post Sales Order
Potentially Post FR would be preferable
Post Payment

Otherwise
Get matching sales order id
get matching fr id
get matching payment id

---

POST Shipment
Builds a list of shipments from ns
SELECT 
custbody_jffd_ch_order_id AS oms_ordersummary_id,
custbody_rsm_fr_id AS fr_id,
if.id AS if_id, 
ifp.packagedescr AS package_description, 
ifp.packagetrackingnumber AS package_tracking_number, 
ifp.packageweight AS package_weight 

FROM transaction AS if 
INNER JOIN itemfulfillmentpackage AS ifp 
ON ifp.itemfulfillment = if.id 

WHERE if.recordtype = 'itemfulfillment' 
AND if.custbody_jffd_ch_shipment_id is null 
AND if.custbody_jffd_cust_entity_id = '13145' 
AND if.createddate >= "

Looks through itemFulfillments in NS where there is no shipment id from sf after starting date and stores the order ids

Gets Infromation from FulfillmentOrders in SF w/ matching order ids
