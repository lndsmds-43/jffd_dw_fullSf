import * from scratch::vars

fun convertHeader() =
    vars.purchaseOrder.header - "orderNumber" ++ {"enriched with" : "ovaltine" }