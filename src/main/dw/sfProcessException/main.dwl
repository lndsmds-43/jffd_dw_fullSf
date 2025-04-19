%dw 2.0
//import * from sfProcessException::orderSummary
import * from modules::sfFunctions

var orderSummaryResponse = getRecords(sfProcessException::orderSummary::response)
var exceptionResponse = getRecords(sfProcessException::exception::response)
var exceptionByOrderResponse = getRecords(
    sfProcessException::exceptionByOrder::response
)
output text/plain ---
executable(sfProcessException::exception::queryAll)  


// output application/json
// ---
// sfProcessException::exceptionByOrder::resolvedOrders