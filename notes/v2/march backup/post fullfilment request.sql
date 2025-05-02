post  fullfilment request
post monitor fullfilment request creation

resources

fullfilmentOrderPayload

postShipment
postmonitorfullfilmentrequest
fr id

1) Query SF: SELECT - Order Summary
	- WHERE Status IN "Waiting for store to fulfill", "Assigned to Store", "Fulfilled by store", "Approved"
	- AND NS Sales Order ID = "pending"
	- AND Last Modified Timestamp < 10 Days Old
2a) Query NS: SELECT - Sales Order
	- WHERE ch_order_id = id from #1
2b) Query SF: PATCH - Order Summary
	- Set NS Sales Order ID = id from #2a
3a) Query SF: SELECT - Order Payment Summary
	- WHERE NS Customer Deposit ID = null
	- AND Capture Amount > 0
	- AND Order Summary NS Sales Order ID = id from #2a
3b) Query NS: POST - Customer Deposit
3c) Query SF: PATCH - Order Payment Summary
	- Set NS Customer Deposit ID = "pending"
4a) Choice: If items from #1 have a status of "Approved", proceed
4b) Query SF: SELECT Fulfillment Orders
	- WHERE Order Summary ID = id from #1
4c) Query SF: PATCH Fulfillment Orders
	- Set NS Fulfillment Request ID = "pending"



Not getting set to pending
During the post fullfimnet request request query so flow

Goes through that 

post full

post shipment

vars sfRespMapping

We're not getting the records back because it's never being set to pending
pos

orderSummaryStatus 

Not an approved status and not false



--SF--
Fulfillment Order