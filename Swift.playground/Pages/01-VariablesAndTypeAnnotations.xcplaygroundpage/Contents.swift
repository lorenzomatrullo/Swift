// Chapter 1: Variables and type annotations

import Foundation

// Type annotation: declare the type up front when there is no initial value
//var x: Int
var x: Int          // declaration
x = 10              // initialization
var y: Int = 5      // declaration and initialization on one line
print(x)
print(y)

// Variables and constants with type inference
// The compiler infers the type from the initial value.
// let is a const variable
let name = "Lorenzo"
let PI = 3.14159
print("my name is", name)
print("PI =", PI)

var age = 20
age = 21                    // vars are mutable
print(age)

let 😃 = "funny"            // even emoji can be used as an identifier
print(😃)
