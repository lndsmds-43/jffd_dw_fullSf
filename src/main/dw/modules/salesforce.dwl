import * from dw::core::Strings
import * from dw::util::Values
fun toJson(string) = 
{
    (substringBefore(string, ":")) 
    : read(substringAfter(string, ":"), "application/json")
}

fun jsonifySfField(obj, fieldName) = 
    obj update field(fieldName) with toJson($)

fun sf(records) = records map ((entry) -> entry - "attributes" orderBy lower($$))

fun sfFile(relative) = 
    readUrl("classpath:" ++ substringAfter(relative replace "\\" with "//", "dw"), "application/json")
    map ((entry) -> entry - "attributes" orderBy lower($$))

fun toJson(string) = 
{
    (substringBefore(string, ":")) 
    : read(substringAfter(string, ":"), "application/json")
}