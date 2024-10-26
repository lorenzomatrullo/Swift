/*
 Functions:
    void func,
    parameters,
    multi-parameters
*/

import Foundation

// FUNCTIONS
func displayPI() {
    print("3.14159")
}

displayPI()



// FUNCTION (parameters)
func triple(value: Int) {
    let result = value * 3
    print("If you multiply \(value) by 3, you'll get \(result)")
}

triple(value: 10)



// FUNCTIONS (multi-parameters)
func multiply(firstNumber: Int, secondNumber: Int) {
    let result = firstNumber * secondNumber
    print("The result is \(result)")
}

multiply(firstNumber: 10, secondNumber: 5)
