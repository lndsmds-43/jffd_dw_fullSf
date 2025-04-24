fun executable(q) = write("sf data:query --query \"$(q replace "\r\n" with " ")\" --json | clip", "text/plain")
fun executableNoClip(q) = write("sf data:query --query \"$(q replace "\r\n" with " ")\" --json", "text/plain")
fun executableQuery(q) = write("sf data:query --query \"$(q replace "\r\n" with " ")\" --json | clip", "text/plain")
 


fun records(return) = return.result.records

fun getRecords(response) = 
response.result.records 
    map (record) -> record orderBy $$

fun executableUpdate(updateFile, sobject) =
"sf data update bulk --file $(updateFile) --sobject $(sobject) --json --async | clip"

fun executableUpdateResume(terminalReturn) = 
"sf data update resume --job-id $(terminalReturn.result.jobId)"