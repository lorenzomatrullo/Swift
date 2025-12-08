import Foundation

// Tuples group multiple values into a single compound value.
// The values can be of any type and don't have to be the same type.

// CREATING TUPLES
let httpStatus = (404, "Not Found")
print(httpStatus)  // (404, "Not Found")

let person = ("Alice", 30, true)
print(person)  // ("Alice", 30, true)

// ACCESSING TUPLE VALUES by index
let statusCode = httpStatus.0
let statusMessage = httpStatus.1
print("Status: \(statusCode) - \(statusMessage)")

// DECOMPOSING TUPLES into separate constants or variables
let (code, message) = httpStatus
print("Code: \(code)")
print("Message: \(message)")

// Use underscore (_) to ignore parts you don't need
let (justCode, _) = httpStatus
print("Only the code: \(justCode)")

// NAMED TUPLE ELEMENTS make your code more readable
let namedStatus = (code: 200, message: "OK")
print(namedStatus.code)      // 200
print(namedStatus.message)   // "OK"

// Tuples are useful for returning multiple values from functions
func getMinMax(numbers: [Int]) -> (min: Int, max: Int)? {
    guard let first = numbers.first else {
        return nil
    }

    var currentMin = first
    var currentMax = first

    for number in numbers {
        if number < currentMin {
            currentMin = number
        }
        if number > currentMax {
            currentMax = number
        }
    }

    return (currentMin, currentMax)
}

if let result = getMinMax(numbers: [5, 2, 8, 1, 9]) {
    print("Min: \(result.min), Max: \(result.max)")
}

// Tuples in switch statements
let coordinates = (x: 10, y: 20)

switch coordinates {
case (0, 0):
    print("At origin")
case (let x, 0):
    print("On x-axis at \(x)")
case (0, let y):
    print("On y-axis at \(y)")
case (let x, let y):
    print("At coordinates (\(x), \(y))")
}

// Comparing tuples (compared left-to-right, one value at a time)
print((1, "apple") < (2, "banana"))  // true (1 < 2)
print((2, "apple") < (2, "banana"))  // true ("apple" < "banana")
