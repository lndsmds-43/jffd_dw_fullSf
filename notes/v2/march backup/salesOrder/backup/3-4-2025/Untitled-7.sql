SELECT Id, Status, TotalDeliveryAmount, OrderNumber, BillingStreet, BillingPostalCode, BillingState, BillingStateCode, BillingCity, BillingCountry, BillingCountryCode, CreatedDate,
  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail,
  (SELECT Id, FulfilledToPhone, FulfilledFromLocation.Id, FulfilledFromLocation.Name, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode
  FROM FulfillmentOrders
  ),
  (SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c, TotalLineAmount,
    (SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name,
        TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END
      FROM OrderItemAdjustmentLineItemSummaries
    )
  FROM OrderItemSummaries
  WHERE Status IN ('ALLOCATED', 'FULFILLED')
    OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')
  )
FROM OrderSummary
WHERE OrderNumber='stg-00105493'
LIMIT 5

SELECT Id, Status, TotalDeliveryAmount, OrderNumber, BillingStreet, BillingPostalCode, BillingState, BillingStateCode, BillingCity, BillingCountry, BillingCountryCode, CreatedDate,
  Account.Id,  Account.Name,  Account.Phone,  Account.PersonEmail,
  (SELECT Id, FulfilledToPhone, FulfilledFromLocation.Id, FulfilledFromLocation.Name, FulfilledToStreet, FulfilledToName, FulfilledToPostalCode, FulfilledToState, FulfilledToStateCode, FulfilledToCity, FulfilledToCountry, FulfilledToCountryCode
  FROM FulfillmentOrders
  ),
  (SELECT Id, Name, TotalTaxAmount, UnitPrice, QuantityNetOrdered, NS_Item_ID__c, TotalLineAmount,
    (SELECT Id, Name, OrderItemSummaryId, TotalAmtWithTax, OriginalOrderItemAdjustmentLineItem.Name,
        TYPEOF AdjustmentCause WHEN Promotion THEN Id, Name, NS_Item_ID__c END
      FROM OrderItemAdjustmentLineItemSummaries
    )
  FROM OrderItemSummaries
  WHERE Status IN ('ALLOCATED', 'FULFILLED')
    OR Name IN ('Shipping - Frozen', 'Shipping - Ambient')
  )
FROM OrderSummary
WHERE NS_Sales_Order_ID__c = null AND Status IN ('Waiting for Store to Fulfill', 'Assigned to Store', 'Fulfilled by Store', 'Approved') AND CreatedDate > 2024-06-01T01:24:51.000+0000 AND LastModifiedDate > 2025-03-01T01:24:51.000+0000
LIMIT 5



[
  {
    "attributes": {
      "type": "OrderSummary",
      "url": "/services/data/v62.0/sobjects/OrderSummary/1OsVF000000gSPh0AM"
    },
    "Id": "1OsVF000000gSPh0AM",
    "Status": "Waiting to Fulfill",
    "TotalDeliveryAmount": 39.98,
    "OrderNumber": "stg-00105493",
    "BillingStreet": "13046 Signature Point Unit 1",
    "BillingPostalCode": "92130",
    "BillingState": "California",
    "BillingStateCode": "CA",
    "BillingCity": "San Diego",
    "BillingCountry": "United States",
    "BillingCountryCode": "US",
    "CreatedDate": "2025-03-03T17:20:07.000+0000",
    "Account": {
      "attributes": {
        "type": "Account",
        "url": "/services/data/v62.0/sobjects/Account/001VF000008C17DYAS"
      },
      "Id": "001VF000008C17DYAS",
      "Name": "Bella QA",
      "Phone": null,
      "PersonEmail": "bellap@justfoodfordogs.com"
    },
    "FulfillmentOrders": null,
    "OrderItemSummaries": [
      {
        "attributes": {
          "type": "OrderItemSummary",
          "url": "/services/data/v62.0/sobjects/OrderItemSummary/10uVF00000201W1YAI"
        },
        "Id": "10uVF00000201W1YAI",
        "Name": "Shipping - Ambient",
        "TotalTaxAmount": 0,
        "UnitPrice": 19.99,
        "QuantityNetOrdered": 1,
        "NS_Item_ID__c": null,
        "TotalLineAmount": 19.99,
        "OrderItemAdjustmentLineItemSummaries": [
          {
            "attributes": {
              "type": "OrderItemAdjustmentLineSummary",
              "url": "/services/data/v62.0/sobjects/OrderItemAdjustmentLineSummary/0ahVF0000002yw9YAA"
            },
            "Id": "0ahVF0000002yw9YAA",
            "Name": "Shipping Price Adjustment",
            "OrderItemSummaryId": "10uVF00000201W1YAI",
            "TotalAmtWithTax": -19.99,
            "OriginalOrderItemAdjustmentLineItem": {
              "attributes": {
                "type": "OrderItemAdjustmentLineItem",
                "url": "/services/data/v62.0/sobjects/OrderItemAdjustmentLineItem/3qZVF0000003sv82AA"
              },
              "Name": "Shipping Price Adjustment"
            },
            "AdjustmentCause": {
              "attributes": {
                "type": "Promotion",
                "url": "/services/data/v62.0/sobjects/Promotion/0c84T000000XZJaQAO"
              },
              "Id": "0c84T000000XZJaQAO",
              "Name": "Dry Goods Free Shipping Applied",
              "NS_Item_ID__c": "4044"
            }
          }
        ]
      },
      {
        "attributes": {
          "type": "OrderItemSummary",
          "url": "/services/data/v62.0/sobjects/OrderItemSummary/10uVF00000201W4YAI"
        },
        "Id": "10uVF00000201W4YAI",
        "Name": "Shipping - Frozen",
        "TotalTaxAmount": 0,
        "UnitPrice": 19.99,
        "QuantityNetOrdered": 1,
        "NS_Item_ID__c": null,
        "TotalLineAmount": 19.99,
        "OrderItemAdjustmentLineItemSummaries": null
      }
    ]
  }
]