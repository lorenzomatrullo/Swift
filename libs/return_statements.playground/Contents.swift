/*
 Return Statements:
    argument labels,
    argument parameters (omitting labels),
    default parameter values
*/

import Foundation

// RETURN STATEMENT
func multiply(firstNumber: Int, secondNumber: Int) -> Int {
    return firstNumber * secondNumber
}

let result = multiply(firstNumber: 10, secondNumber: 5)
print("10 * 5 is \(result)")



// ARGUMENT LABELS (omitting labels)
func add(_ firstNumber: Int, _ secondNumber: Int) -> Int {
    return firstNumber + secondNumber
}

let total = add(14, 6)
print(total)



// DEFAULT PARAMETER VALUES
func display(teamName: String, score: Int = 0) {
    print("\(teamName): \(score)")
}

display(teamName: "Wombats")
display(teamName: "Wombats", score: 100)
