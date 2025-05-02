[
  {
    "Id": "1OsVF0000001u6b0AA", // externalId === header.externalId ?
    "Status": "Approved", // Used in Ifs === ref?
    "TotalDeliveryAmount": 19.99, // shippingCost === shippingInstructions.item.cost
    "OrderNumber": "stg-00096715", // otherrefnum === header.orderNumber??? externalRef?
    "BillingStreet": "18905 Kill Creek Road", // billingAdress.addr1 === billTo.address.line1
    "BillingPostalCode": "66021", // billingAddress.zip === billTo.address.postalCode
    "BillingStateCode": "KS", // billingAddress.state === billTo.address.state
    "BillingCity": "Edgerton", // billingAdress.city === billTo.address.city
    "BillingCountry": "United States", // billingAdress.country.refName === ? address.ref?
    "BillingCountryCode": "US", // billingAddress.country.id === billTo.address.countryCode

    "CreatedDate": "2024-06-06T17:19:38.000+0000", // goes to tranDate, dateTime not date currently. Could do PST transform in Sapi then set to header.orderDate

    "batchId__c": "1400433", // payment info === nothing yet
    "Account": {
      "Name": "Anubhav Mangla", // billingAddress.attention and addressee === billTo.name
    },
    "FulfillmentOrders": [
      {
        "Id": "0a3VF0000000nQYYAY", // Patch === not sure
        "FulfilledToPhone": "469-777-8550", // custbody_jffd_customer_phone === shipTo.contact.phone
        "FulfilledToEmailAddress": "anubhav.mangla@caeliusconsulting.com", // custbody_jffd_customer_email === shipTo.contact.email
        "FulfilledFromLocation": {
          "Id": "1314T0000000MOMQA2", // Used in fetchLocation === not sure
        },
        "FulfilledToStreet": "18905 Kill Creek Road", // shippingAddress.addr1 === shipTo.address.line1
        "FulfilledToName": "Anubhav Mangla", // custbody+jffd+customer_name === shipTo.contact.name
        "FulfilledToPostalCode": "66021", // shippingAddress.zip === shipTo.address.postalCode
        "FulfilledToStateCode": "KS", // shippingAddress.state === shipTo.address.state
        "FulfilledToCity": "Edgerton", // shippingAddress.city === shipTo.address.city
        "FulfilledToCountry": "United States", // shippingAddress.country.refName === address ?
        "FulfilledToCountryCode": "US" // shippingAddress.country.id === shipTo.address.countryCode
      }
    ],
    "OrderItemSummaries": [
      {
        "Name": "Chicken & White Rice 5.5 oz (18 Pack) Small Box", // item.items.refName
        "TotalTaxAmount": 0, // Used in if statements for tax summaries, diferent than just amount/rate (checks if > 0 so could just be bool) === item ?
        "UnitPrice": 64.99,  // item.items.item.rate === item.unitPrice
        "QuantityNetOrdered": 2, //item.items.item.quantity === item.quantity
        "NS_Item_ID__c": "6653", // item.items.item.id === item.id this is nsId
      }
    ],
    "OrderItemAdjustmentLineItemSummaries": [
      {
        "Name": "FBS100401020004 - 50% off Chicken & White Rice 5.5 oz - 18 & 36 Packs", // item.items.item.refName === item.description
        "OrderItemSummaryId": "10uVF000000MCtmYAG", // if statement === item. ? this is the sf id
        "TotalAmtWithTax": -65, // item.items.item.rate === item.unitPrice === item.unitPrice
        "OriginalOrderItemAdjustmentLineItem": { 
          "Name": "FBS100401020004 - 50% off Chicken & White Rice 5.5 oz - 18 & 36 Packs" // item.ref.name === item.description
        }, 
        "AdjustmentCause": { 
          "NS_Item_ID__c": "8082" // item.items.item.id === item.id this is nsId
        }
      }
    ],
    "OrderPaymentSummaries": [ // new; just refs?
    
      {
        "Id": "0bMVF000000152T2AQ",
        "Method": "Visa - 5262",
        "CapturedAmount": 84.97
      }
    ]
  }
]