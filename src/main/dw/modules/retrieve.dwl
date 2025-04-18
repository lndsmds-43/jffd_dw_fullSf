import * from dw::core::Strings
import try from dw::Runtime

fun transformRelativePath(classPath) =
do {
    var writtenAsJson = write(classPath, "application/json")
    var removeQuotation = writtenAsJson remove "\""
    var replaceDoubleBackslash = removeQuotation replace "\\\\" with "//"
    var replaceSingleBackslash = replaceDoubleBackslash replace "\\" with "//"
    var trimDirectory = substringAfter(replaceSingleBackslash, "dw//")
    ---
    "classpath://" ++ trimDirectory
}

fun get(relativeClassPath) = 
    readUrl(transformRelativePath(relativeClassPath))

fun getJson(relativeClassPath) = 
    readUrl(transformRelativePath(relativeClassPath), "application/json")


fun getByRelative(relativeClassPath) =
    get(relativeClassPath)

fun get(folder, file) = do {
    var tryRead  = 
        try(() ->
        readUrl("classpath://" ++ folder ++ "//" ++ file, "application/json"))
    ---
    if (tryRead.success == true) tryRead.result
    else null
}

fun run(script)= 
    readUrl("classpath://" ++ (script as String) ++  ".dwl", "application/dw")


