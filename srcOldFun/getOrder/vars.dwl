%dw 2.0 output application/json
import * from modules::retrieve
import * from dw::core::Strings

var vars = {
    "attributes" : get("src\main\dw\getOrder\vars\attributes")
}
var classPath = "src\main\dw\getOrder\variable.json"
var classPath2 = "src\main\dw\buildMessage\purchaseOrder.json"

--- 
vars
/*
fun transformRelativePath(classPath) =
do {
    var writtenAsJson = write(classPath, "application/json")
    var removeQuotation = writtenAsJson remove "\""
    var replaceBackslash = removeQuotation replace "\\\\" with "//"
    var trimDirectory = substringAfter(replaceBackslash, "dw\\")
    ---
    "classpath://" ++ trimDirectory
}
*/
//src\main\dw\getOrder\variable.json
/*
do {
    var writtenAsJson = write(classPath2, "application/json")
    var removeQuotation = writtenAsJson remove "\""
    var removeDoubleBackslash = removeQuotation replace "\\\\" with "//"
    var removeSingleBackslash = removeDoubleBackslash replace "\\" with "//"
    var trimDirectory = substringAfter(removeSingleBackslash, "dw//")
    ---
    "classhpath://" ++ trimDirectory
}
*/