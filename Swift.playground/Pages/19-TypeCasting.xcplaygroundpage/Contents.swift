import Foundation

// Type casting means turning a value of one type into another type
// when it makes sense, for example Int -> Double.

let intNumber = 3
let doubleNumber = 1.6475

// Here we convert intNumber to Double so we can add two Doubles together.
let total = Double(intNumber) + doubleNumber
print("Total as Double:", total)

// You can also go the other way, but you may lose information.
let rounded = Int(doubleNumber)    // decimal part is dropped
print("Rounded Int:", rounded)
