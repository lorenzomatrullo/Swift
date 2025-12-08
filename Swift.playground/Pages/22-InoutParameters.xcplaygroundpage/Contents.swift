import Foundation

// Function parameters are constants by default.
// Inout parameters allow a function to modify a parameter's value
// and have those changes persist after the function call ends.

// BASIC INOUT PARAMETER
// Use the 'inout' keyword before the parameter type
func doubleValue(_ number: inout Int) {
    number *= 2
}

var value = 5
print("Before: \(value)")
doubleValue(&value)  // Use & to pass the variable as inout
print("After: \(value)")  // 10

// SWAPPING VALUES
// A classic use case for inout parameters
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var firstNumber = 10
var secondNumber = 20
print("Before swap: \(firstNumber), \(secondNumber)")
swapTwoValues(&firstNumber, &secondNumber)
print("After swap: \(firstNumber), \(secondNumber)")

var firstName = "Alice"
var secondName = "Bob"
print("Before swap: \(firstName), \(secondName)")
swapTwoValues(&firstName, &secondName)
print("After swap: \(firstName), \(secondName)")

// MODIFYING STRUCT PROPERTIES
struct Point {
    var x: Int
    var y: Int
}

func movePoint(_ point: inout Point, byX deltaX: Int, byY deltaY: Int) {
    point.x += deltaX
    point.y += deltaY
}

var location = Point(x: 5, y: 10)
print("Before: (\(location.x), \(location.y))")
movePoint(&location, byX: 3, byY: -2)
print("After: (\(location.x), \(location.y))")

// MULTIPLE INOUT PARAMETERS
func updateValues(_ a: inout Int, _ b: inout Int, _ c: inout Int) {
    a += 1
    b *= 2
    c -= 5
}

var num1 = 10
var num2 = 5
var num3 = 20
print("Before: \(num1), \(num2), \(num3)")
updateValues(&num1, &num2, &num3)
print("After: \(num1), \(num2), \(num3)")

// MODIFYING ARRAYS
func appendAndDouble(_ array: inout [Int], value: Int) {
    array.append(value)
    array = array.map { $0 * 2 }
}

var numbers = [1, 2, 3]
print("Before: \(numbers)")
appendAndDouble(&numbers, value: 4)
print("After: \(numbers)")  // [2, 4, 6, 8]

// IMPORTANT RULES ABOUT INOUT PARAMETERS:
// 1. Cannot pass constants or literals as inout
//    doubleValue(&10)  // ERROR: Cannot pass immutable value
//    let constant = 5
//    doubleValue(&constant)  // ERROR: Cannot pass let constant

// 2. Cannot pass the same variable as multiple inout parameters
//    swapTwoValues(&value, &value)  // ERROR

// 3. Inout parameters cannot have default values
//    func example(_ x: inout Int = 5) { }  // ERROR

// 4. Variadic parameters cannot be inout
//    func example(_ numbers: inout Int...) { }  // ERROR

// PRACTICAL EXAMPLE: Normalizing a string in place
func normalize(_ text: inout String) {
    text = text.trimmingCharacters(in: .whitespaces)
    text = text.lowercased()
    text = text.replacingOccurrences(of: " ", with: "-")
}

var title = "  Hello World  "
print("Original: '\(title)'")
normalize(&title)
print("Normalized: '\(title)'")

// INOUT vs RETURNING A VALUE
// Instead of inout:
func doubleAndReturn(_ number: Int) -> Int {
    return number * 2
}

// With inout, you modify the original variable
// With return, you create a new value
// Choose inout when you want to modify the original variable in place
