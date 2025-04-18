%dw 2.0
//import * from sfProcessException::orderSummary
import * from modules::sfFunctions

var orderSummaryResponse = getRecords(sfProcessException::orderSummary::response)
var exceptionResponse = getRecords(sfProcessException::exception::response)
var exceptionByOrderResponse = getRecords(
    sfProcessException::exceptionByOrder::response
)
// output text/plain ---
// executable(sfProcessException::exceptionByOrder::query) 


output application/json
---

exceptionByOrderResponse
groupBy ((orderExceptions) -> orderExceptions.OrderSummaryId)
mapObject ((exceptionsInfo, orderSummaryId) -> 
    (orderSummaryId) : 
        (exceptionsInfo.StatusCategory contains "RESOLVED")
        and
        not (exceptionsInfo.StatusCategory contains "ACTIVE")
    )
filterObject ((value_isResolved) -> value_isResolved)
pluck ((value_isResolved, orderSummaryId, index) -> orderSummaryId)
/*[
  "1OsVF000000xQg20AE"
]



// exceptionByOrderResponse
// groupBy ((order) -> order.OrderSummaryId)
// mapObject ((value, key) -> 
//     (key) : 
//         (value.StatusCategory contains "RESOLVED")
//         and
//         not (value.StatusCategory contains "ACTIVE")
//     )
// filterObject ($)
/*
{
  "1OsVF000000xQg20AE": true
}
*/

// sfProcessException::exceptionByOrder::groupedExceptions

// mapObject ((value, key, index) -> {
//     (key) : (
//         (value.StatusCategory contains "RESOLVED")
//         and
//         !(value.StatusCategory contains "ACTIVE")
//     )
//     })
// filterObject ((value, key, index) -> value)
/*
{
  "1OsVF000000xQg20AE": true
}
*/



// Makes a map that kind of corresponds
// mapObject ((value, key, index) -> {
//     (key) : (
//         (value.StatusCategory contains "RESOLVED")
//         and
//         !(value.StatusCategories contains "ACTIVE")
//     )
//     })
/*
{
  "1OsVF000000rCRF0A2": false,
  "1OsVF000000rVaM0AU": false,
  "1OsVF000000rXfO0AU": false,
  "1OsVF000000rlK90AI": false,
  "1OsVF000000rnLx0AI": false,
  "1OsVF000000sIb50AE": false,
  "1OsVF000000sIuP0AU": false,
  "1OsVF000000sMtB0AU": false,
  "1OsVF000000uCw90AE": false,
  "1OsVF000000x1w90AA": true,
  "1OsVF000000xQg20AE": true,
  "1OsVF000000xqaT0AQ": false,
  "1OsVF000000yU9h0AE": false,
  "1OsVF000000yV2X0AU": false
}
*/

/*
{
  "1OsVF000000x1w90AA": true,
  "1OsVF000000xQg20AE": true
}
*/

//filterObject ((value, key, index) -> sizeOf(value.StatusCategory) > 1)

// filterObject( (record) -> 
// record[0].StatusCategory == "ACTIVE"

// )