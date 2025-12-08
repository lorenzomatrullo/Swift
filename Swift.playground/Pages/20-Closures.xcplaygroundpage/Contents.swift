import Foundation

// Closures are self-contained blocks of functionality that can be passed around.
// They are similar to functions but written in a more compact syntax.
// Functions are actually special cases of closures.

// BASIC CLOSURE SYNTAX
// { (parameters) -> ReturnType in
//     statements
// }

// Example: A simple closure assigned to a variable
let greeting = { (name: String) -> String in
    return "Hello, \(name)!"
}
print(greeting("Alice"))

// CLOSURES AS FUNCTION PARAMETERS
func performOperation(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

// Using a closure to define the operation
let sum = performOperation(a: 5, b: 3, operation: { (x: Int, y: Int) -> Int in
    return x + y
})
print("Sum: \(sum)")

let multiply = performOperation(a: 5, b: 3, operation: { (x: Int, y: Int) -> Int in
    return x * y
})
print("Multiply: \(multiply)")

// TRAILING CLOSURE SYNTAX
// If a closure is the last parameter, you can write it outside the parentheses
let subtract = performOperation(a: 10, b: 4) { (x: Int, y: Int) -> Int in
    return x - y
}
print("Subtract: \(subtract)")

// TYPE INFERENCE
// Swift can infer parameter types and return type
let divide = performOperation(a: 20, b: 4) { x, y in
    return x / y
}
print("Divide: \(divide)")

// IMPLICIT RETURNS
// Single-expression closures can omit the 'return' keyword
let power = performOperation(a: 2, b: 3) { x, y in
    Int(pow(Double(x), Double(y)))
}
print("Power: \(power)")

// SHORTHAND ARGUMENT NAMES
// Use $0, $1, $2, etc. to refer to closure arguments
let remainder = performOperation(a: 10, b: 3) {
    $0 % $1
}
print("Remainder: \(remainder)")

// CLOSURES WITH ARRAYS
let numbers = [5, 2, 8, 1, 9, 3]

// sorted(by:) takes a closure that defines sorting logic
let sortedAscending = numbers.sorted { $0 < $1 }
print("Ascending: \(sortedAscending)")

let sortedDescending = numbers.sorted { $0 > $1 }
print("Descending: \(sortedDescending)")

// CAPTURING VALUES
// Closures can capture and store references to variables from their surrounding context
func makeIncrementer(incrementAmount: Int) -> () -> Int {
    var total = 0
    let incrementer = {
        total += incrementAmount
        return total
    }
    return incrementer
}

let incrementByTwo = makeIncrementer(incrementAmount: 2)
print(incrementByTwo())  // 2
print(incrementByTwo())  // 4
print(incrementByTwo())  // 6

// Each closure captures its own separate total
let incrementByFive = makeIncrementer(incrementAmount: 5)
print(incrementByFive())  // 5
print(incrementByFive())  // 10

// ESCAPING CLOSURES
// An escaping closure outlives the function it was passed to
// Commonly used in asynchronous operations
var completionHandlers: [() -> Void] = []

func addCompletionHandler(handler: @escaping () -> Void) {
    completionHandlers.append(handler)  // Closure escapes the function
}

addCompletionHandler {
    print("Task completed!")
}

// Execute all stored handlers
for handler in completionHandlers {
    handler()
}

// AUTOCLOSURES
// @autoclosure automatically creates a closure from an expression
func logIfTrue(_ condition: @autoclosure () -> Bool, message: String) {
    if condition() {
        print("Log: \(message)")
    }
}

let debugMode = true
logIfTrue(debugMode, message: "Debug is enabled")
// The boolean expression is automatically wrapped in a closure
