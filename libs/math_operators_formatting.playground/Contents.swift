/*
    math_operators & formatting
*/

import Foundation

// Formatting
var hugeNumber = 1000000                // not good looking number
var formattedNumber = 1_000_000         // same number as the one above
print(hugeNumber)
print(formattedNumber)


// Math Operators
var addition = 6 + 6
var subtraction = 6 - 1
var multiplication = 6 * 6
var division = 6 / 3


// Content Update
var myScore = 10
myScore += 2            // adds 2
myScore -= 2            // subtracts 2
myScore *= 2            // multiplies by 2
myScore /= 2            // divides by 2

var example = 2
example = example + 2   // 2 = 2 + 2 so now example will be 4


// Decimal Numbers Operations
var totalDistance = 3.9
var distanceTravelled = 1.2
var remainingDistance = totalDistance - distanceTravelled
print(remainingDistance)
