// Chapter 6: Ternary operator

import Foundation

// The ternary operator has the form:
// condition ? valueIfTrue : valueIfFalse
// It evaluates to one of the two values depending on the Boolean condition.
var largest: Int
let a = 15
let b = 4

largest = a > b ? a : b

// The code above is equivalent to:
// if a > b {
//     largest = a
// } else {
//     largest = b
// }

// You can also use it directly inside other expressions.
let description = largest > 10 ? "Larger than 10" : "10 or less"
print(description)
