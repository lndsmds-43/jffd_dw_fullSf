%dw 2.5

var vars = {
    input1 : imports::input1::value,
    roadmap : imports::roadmap::value,
    x2 : imports::x2::value,
    calculated : imports::calculated::value
}
---
imports::calculated::run(vars)