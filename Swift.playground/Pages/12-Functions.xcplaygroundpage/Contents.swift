// Chapter 12: Functions

import Foundation

// Function with no parameters and no return value
func displayPI() {
    print("3.14159")
}

displayPI()

// Function with a single parameter
func triple(value: Int) {
    let result = value * 3
    print("If you multiply \(value) by 3, you'll get \(result)")
}

triple(value: 10)

// Function with multiple parameters
func multiply(firstNumber: Int, secondNumber: Int) {
    let result = firstNumber * secondNumber
    print("The result is \(result)")
}

multiply(firstNumber: 10, secondNumber: 5)
