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
sfProcessException::exceptionByOrder::groupedExceptions
// "fefef

// Makes a map that kind of corresponds
// mapObject ((value, key, index) -> {
//     "OrderSummaryId" : key,
//     "StatusCategories" : (
//         (value.StatusCategory contains "RESOLVED")
//         and
//         !(value.StatusCategories contains "ACTIVE")
//     )
//     })

//filterObject ((value, key, index) -> sizeOf(value.StatusCategory) > 1)

// filterObject( (record) -> 
// record[0].StatusCategory == "ACTIVE"

// )