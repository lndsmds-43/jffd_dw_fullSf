%dw 2.0
import webhook::message
var message = webhook::message::main(payload : {}).msg
---
message