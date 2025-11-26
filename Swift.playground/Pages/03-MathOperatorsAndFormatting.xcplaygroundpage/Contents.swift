// Chapter 3: Math operators and number formatting

import Foundation

// Formatting large numbers with underscores for readability
var hugeNumber = 1000000
var formattedNumber = 1_000_000
print(hugeNumber)
print(formattedNumber)

// Basic math operators
var addition = 6 + 6
var subtraction = 6 - 1
var multiplication = 6 * 6
var division = 6 / 3

// Updating a numeric value in place with compound assignment
var myScore = 10
myScore += 2
myScore -= 2
myScore *= 2
myScore /= 2

var example = 2
example = example + 2

// Operations with decimal (Double) values
var totalDistance = 3.9
var distanceTravelled = 1.2
var remainingDistance = totalDistance - distanceTravelled
print(remainingDistance)
