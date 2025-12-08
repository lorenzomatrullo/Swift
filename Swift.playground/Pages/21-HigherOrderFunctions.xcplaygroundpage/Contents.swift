import Foundation

// Higher-order functions are functions that take closures as parameters
// or return closures. They enable functional programming patterns.
// Common ones: map, filter, reduce, compactMap, flatMap, forEach

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// MAP - transforms each element using a closure
// Returns a new array with transformed values
let squared = numbers.map { $0 * $0 }
print("Squared: \(squared)")  // [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

let strings = numbers.map { "Number \($0)" }
print("Strings: \(strings)")

// FILTER - selects elements that match a condition
// Returns a new array with only matching elements
let evenNumbers = numbers.filter { $0 % 2 == 0 }
print("Even numbers: \(evenNumbers)")  // [2, 4, 6, 8, 10]

let greaterThanFive = numbers.filter { $0 > 5 }
print("Greater than 5: \(greaterThanFive)")  // [6, 7, 8, 9, 10]

// REDUCE - combines all elements into a single value
// Takes an initial value and a combining closure
let sum = numbers.reduce(0) { $0 + $1 }
print("Sum: \(sum)")  // 55

let product = numbers.reduce(1) { $0 * $1 }
print("Product: \(product)")  // 3628800

// Reduce with more readable syntax
let concatenated = numbers.reduce("") { result, number in
    result + String(number) + " "
}
print("Concatenated: \(concatenated)")

// COMPACTMAP - maps and removes nil values
// Very useful for optional transformations
let stringNumbers = ["1", "2", "three", "4", "five"]
let validNumbers = stringNumbers.compactMap { Int($0) }
print("Valid numbers: \(validNumbers)")  // [1, 2, 4]

let optionalNumbers: [Int?] = [1, nil, 3, nil, 5]
let unwrapped = optionalNumbers.compactMap { $0 }
print("Unwrapped: \(unwrapped)")  // [1, 3, 5]

// FLATMAP - maps and flattens nested arrays
let nestedArrays = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]
let flattened = nestedArrays.flatMap { $0 }
print("Flattened: \(flattened)")  // [1, 2, 3, 4, 5, 6, 7, 8, 9]

// FlatMap with transformation
let words = ["Hello", "World"]
let letters = words.flatMap { $0 }
print("Letters: \(letters)")  // Array of characters

// FOREACH - executes a closure for each element (no return value)
// Use this when you need side effects, not transformation
print("Printing each number:")
numbers.forEach { number in
    print("- \(number)")
}

// CHAINING HIGHER-ORDER FUNCTIONS
// These can be combined for powerful data transformations
let result = numbers
    .filter { $0 % 2 == 0 }      // Keep even numbers: [2, 4, 6, 8, 10]
    .map { $0 * $0 }              // Square them: [4, 16, 36, 64, 100]
    .reduce(0) { $0 + $1 }        // Sum them up: 220
print("Chained result: \(result)")

// PRACTICAL EXAMPLE: Processing user data
struct User {
    let name: String
    let age: Int
    let email: String?
}

let users = [
    User(name: "Alice", age: 28, email: "alice@example.com"),
    User(name: "Bob", age: 17, email: nil),
    User(name: "Charlie", age: 35, email: "charlie@example.com"),
    User(name: "Diana", age: 16, email: "diana@example.com")
]

// Get emails of adult users (18+)
let adultEmails = users
    .filter { $0.age >= 18 }
    .compactMap { $0.email }
print("Adult emails: \(adultEmails)")

// SORTED - sorts elements using a closure
let sortedByAge = users.sorted { $0.age < $1.age }
print("Sorted by age: \(sortedByAge.map { $0.name })")

// CONTAINS and ALLSATISFY
let hasMinor = users.contains { $0.age < 18 }
print("Has minor: \(hasMinor)")  // true

let allAdults = users.allSatisfy { $0.age >= 18 }
print("All adults: \(allAdults)")  // false

// FIRST and LAST with condition
let firstAdult = users.first { $0.age >= 18 }
print("First adult: \(firstAdult?.name ?? "None")")
