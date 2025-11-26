// Chapter 13: Return values and parameter labels

import Foundation

// Function that returns a value.
// The arrow (-> Int) declares that this function returns an Int.
func multiply(firstNumber: Int, secondNumber: Int) -> Int {
    return firstNumber * secondNumber
}

let result = multiply(firstNumber: 10, secondNumber: 5)
print("10 * 5 is \(result)")

// Omitting external argument labels with _.
// Using _ means the caller does not need to write the label, only the value:
// add(14, 6) instead of add(firstNumber: 14, secondNumber: 6).
func add(_ firstNumber: Int, _ secondNumber: Int) -> Int {
    return firstNumber + secondNumber
}

let total = add(14, 6)
print(total)

// Default parameter values
func display(teamName: String, score: Int = 0) {
    print("\(teamName): \(score)")
}

display(teamName: "Wombats")
display(teamName: "Wombats", score: 100)
