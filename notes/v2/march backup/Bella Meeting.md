Creating test orders
stg.justfoodfordogs - staging

dev is not the dev from mule from sf and ns
ns is only stg and prod

ONLY STG sb1

--- Create an account
either immediate or faf

Just add items to cart
And close out
1 item and then just check out

Include one frozen and one ambient

Promo codes

**Basic checkout**

***Account has address***

Sale credit has all the cards you can use
Credit/debit/emv 
All Will Act The Same
CVV doesn't matter nor does expiration date


**Commerce Cloud**
https://login.salesforce.com/?startURL=%2Fsetup%2Fsecur%2FRemoteAccessAuthorizationPage.apexp%3Fsource%3DCAAAAZVnu-0uMDAwMDAwMDAwMDAwMDAwAAAA_tYVFPfZtqw3dz11_Uwp10ggNtRwqrAGynqLU3ye9Pm8CfHHGWubeOcXlR1nJOv6cgWFj4Cf45JSRldxQ-gigwkpHdNte2nQivA9G209NgR4RSfy213rtUfK5sb3f7k_9YBoo3XG-UJ5gX_99dXi_k7JxfWV3JmFqclLuJi-cUjsdAc05op5azssIzH6mHMgiBGU_MizTXzBlh2blRqhgmQZ3BQkQDyeSucjDqK1lOU_yTP3A_QYsqmMoc0gNHJWvAzmF-cmPnm23eSzXJoejT_6_6I_Zt50dYH5k5tnGRmF4RSWQCSKifXOdVBsUZXLKIJ3mLnjbgqj7FE9yVP-vTylRxKhTo-Ina1l4r-oBQd7C2d2rSy_kTxv6wZD9OlsUAG4b98zySlSJe8teWPIv1mycsc3AY9VDpzMGn48BTMhIo0wI_tlPy8QSiNCv8fiaJe3R5O2opEm62W6PeRPU5XxVOgOyIGUUD3PgdU-hx5D9P0C6HQkbUJMJG9OwrVxXcdXHBXANKB5vrcxWWEAOtsUgVuZ6Sl8aQNGJxkHXN-ncBk8Ljj24GyLTXhbmgc8H3-qpidu8pqBVC4I_8fXSnD4Y3B9jDPi0EgXgwmFZ3ePdn06caWt9b9GzaYIOnl7AbtmNPCnTcbIcQbief5MiE25aWTD7oqWhTiB-srBkYc9HtAPqvIzFJvVpymcnDz3GyQXW9wRSXWzNjsUsLFvlko%253D&sdtd=1
Single Sign On
Links directly to SF account

**Business Manager**
Links directly to commerce cloud

Merchant Tools, Orders, Ordering, Orders
Can chceck for orders to see 

This will show you if there are orders 

**History Page**
Will show duplicate value on the OMS side
--- Breaks things currently
Don't have one to one for customers in commerce club and web
Merchants
OMS and Commerce Club are hitting the same id
Supposed to be another id (can only get from customer records)

Wanted to save it in the OMS system

Already has a customer in OMS with the same ID

***If you make another with the same name and address***
Try to use different last name, phone nuber, address, email

Must Create new Accounts each time

**Can trigger it**
Administration - Jobs
Settle Payment Regular should try to process and then send it tome OMS

*OMS System s in the full environment that's what connected to staging

**Staging**
Staging on commerce cloud - sb1 net suite - full sf

**Order Management is where you see all the order info**
Make sure the order managment is in the view

---
**Send to NS**
Make sure the 

**30 Minute Hold**
Is in SF


**SFFFF**
Re-Run Fulfillment in OrderManagement for single Order SUmmaries

**Process Exception**
Errors are fixed by supply chain

**Order Summary Page**
Shows the details include in the NS Id
Also see the NS Fullfillment Request ID
Would Show Shipiment

-----------Chad does the Shipments through POSTMAN--------------
Sometimes difficult to create these though
Was having issues with refresh
Sometimes they put the production one in instead of dev
Struggles with finding new ids because the ids have already been used
He was proposing that we change it to use a different FR x number, Sv1 x number

**Help on NS**
Jason is the best to ask
Willy is the best for accounting data, or finding where something is

**NS Sales Order**
In Fulfillment Request
If you go to integration
3PL Order ID - hey can you process a shipment for Smart WH-Northhampton PA
--ASN Details are needed to create a shipment--
THat job does not run automatically
Need to ask to Jason or Chris what job that is to make ASN
3PL Order ID - email them and ask them to create 3PL Order Id
Just make sure the 3PL id links to an existing
FR is the detail to make sure there arent' duplicates

**Ship From Store**
NS also saves the 'Ship From Store'
Ship From Store - Autoship
Whenever a customer creates their account they don't have the ability to pick ship from store
Supply Chain creates those
They'll go to the customer account and change it to auto ship
Default --None--
Autoship or --None-- ignore the others
Must adjust this ourselves
***MAKE SURE THE RADIUS IS IN THE RADIUS OF THE LOCATION***
---Order Management---
Locations
New view Store Locations
Any one active

"geojson.io"
Copy the json io into the there and as long as it's in the size of the polygon
If outside you try to create fulfillment it will tell you there is no store in radius
Have to ask them for 3PL
In prod, these are picked out by the supply chain
If customer has new address - those orders we'll let them know they can't ship it to store
so send it to coldtrack or warehous
**Location**

THIS Does TAKE A MINUTE 
So DO Need A Scheduler
**SF Job "Calculate_AvaTak job"**
**Verify Order Address** is the seocond job
**SettlePayment_Regular**
Run These to use it off times

**SFCC Customer Number and Id**
Delete these and save it and then trigger the order

Any issue that an order has you can send it to order management

**For 3PL**
There is no job that changes Waiting For Store To Fulfill
Must wait for store to approve, once someone is able to deliver it
Then it goes to ship from store
Then 

**Create FO From Store**
Should auto assign it from store
Scripts that are running on the OMS side that will update it
They handle the FO Creation
Door Dash has a testing environment but OnFleet does not
ON FLEET GOES TO PROD
Only Door Dash


STG -00105297
NO Shipment
Pack Complete is a status
When it's marked as delivered
Now it's created by store

**Auto**
In testing we're not connected to receive any orders from Chewy Or Amazon

**Commerce Cloud**
Don't make changes in dev, will replicate to prod

**

Coldtrack we have to email the support team to create shipments

**Smart Warehouse**
If I 