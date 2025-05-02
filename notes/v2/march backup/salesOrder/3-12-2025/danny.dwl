%dw 2.0
output application/json
var p = payload
---
{
    header: {
        ~~~~ Add to purchase order header base
        ~~ sfLocationId
        ~~ nsLocationId
        ~~ sfOrderId
        ~~ nsOrderId
        ~~ status
        ~~ stgNumber
        ~~ use the generic order date existing
~~~ Move all theses refs to header (opt)
        ref : {
            sfId: p.Id, // or header.externalId
            status: p.Status,
            stgNumber: p.OrderNumber, // or header.orderNum ~~~~~ check with bella
            createdDateTime: p.CreatedDate,
            // CreatedDate is converted to PST and then to a Date in Sync PAPI
            // could happen in this level instead
~~~ Convert in the SF SAPI ~~~~~~~~ header.orderDate


        }
    },
    shippingInstructions : [
        {
            cost: p.TotalDeliveryAmount
        }
    ],
    billTo : {
        address : {
            line1: p.BillingStreet,
            postalCode: p.BillingPostalCode,
            state: p.BillingStateCode,
            city: p.BillingCity,
            countryCode: p.BillingCountryCode,
~~~~ moved countryText to address objected (optional)            
            ref: {
                countryText: p.BillingCountry
            }
        },
        contact: {
            name: p.Account.Name
        },
    },
    shipTo : (p.FulfillmentOrders map {
        address: {
            line1: $.FulfilledToStreet,
            postalCode: $.FulfilledToPostalCode,
            state: $.FulfilledToStateCode,
            city: $.FulfilledToCity,
            countryCode: $.FulfilledToCountryCode,
            ref: {
                countryText: $.FulfilledToCountry, // ~~~~~~~~~~ move to address object or in higher ref
            },
            ~~
            sfLocation
        },
        ref: {
            fulfilledFromLocationId: $.FulfilledFromLocation.Id,
            //FulfilledFromLocationName: $.FulfilledFromLocation.Name,
            sfId: $.Id
        },
        contact: {
            name: $.FulfilledToName, // Or p.Account.Name
            phone: $.FulfilledToPhone,
            email: $.FulfilledToEmailAddress
        }
    })[0],
    lineItems : (
        (p.OrderItemSummaries map {
            description: $.Name,
            unitPrice: $.UnitPrice,
            quantity: $.QuantityNetOrdered,
            ~~ totalTaxAmount (opt)
            ~~ nsItemId (opt)
            ~~ sfItemId (opt)
            ref: {
                totalTaxAmount: $.TotalTaxAmount,
                nsId: $.NS_Item_ID__c
            }
        })
        ++
        (p.OrderItemAdjustmentLineItemSummaries map {
            description: $.OriginalOrderItemAdjustmentLineItem.Name,
            unitPrice: $.TotalAmtWithTax,
            ref: {
                nsId: $.AdjustmentCause.NS_Item_ID__c,
                sfId: $.Id
            }
        }
        )
    ),
    payment : {
        ~~~~~: {
            sfId: p.OrderPaymentSummaries[0].Id,
            nsId : "nsId", // Later used in return for patch
            method: p.OrderPaymentSummaries[0].Method,
            capturedAmount: p.OrderPaymentSummaries[0].CapturedAmount,
            batchId: p.batchId__c
        }
    }
}


///
Purchase Order now has a Customer Deposits array

CustomerDeposit object type Now
customerDeposit[

]