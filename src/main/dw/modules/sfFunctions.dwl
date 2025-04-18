fun executable(q) = write("sf data:query --query \"$(q replace "\r\n" with " ")\" --json | clip", "text/plain")
fun executableNoClip(q) = write("sf data:query --query \"$(q replace "\r\n" with " ")\" --json", "text/plain")

fun records(return) = return.result.records

fun getRecords(response) = 
response.result.records 
    map (record) -> record orderBy $$