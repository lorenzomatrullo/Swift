import Foundation

// Range operators are used to express a range of values.
// They are particularly useful with loops and collections.

// CLOSED RANGE OPERATOR (...) - includes both bounds
// Syntax: a...b (all values from a to b, including b)
for number in 1...5 {
    print(number)  // Prints: 1, 2, 3, 4, 5
}

let closedRange = 0...10
print(closedRange.contains(10))  // true
print(closedRange.contains(11))  // false

// HALF-OPEN RANGE OPERATOR (..<) - excludes upper bound
// Syntax: a..<b (all values from a up to, but not including, b)
for index in 0..<3 {
    print(index)  // Prints: 0, 1, 2
}

// Very useful for working with arrays (since they are zero-indexed)
let colors = ["red", "green", "blue", "yellow"]
for i in 0..<colors.count {
    print("Color \(i): \(colors[i])")
}

// ONE-SIDED RANGES - useful for slicing collections
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// From index 3 to the end
let fromThree = numbers[3...]
print(fromThree)  // [4, 5, 6, 7, 8, 9, 10]

// From the start up to (but not including) index 5
let upToFive = numbers[..<5]
print(upToFive)  // [1, 2, 3, 4, 5]

// From the start up to and including index 4
let throughFour = numbers[...4]
print(throughFour)  // [1, 2, 3, 4, 5]

// Ranges also work with characters
let letterRange = "a"..."e"
print(letterRange.contains("c"))  // true
print(letterRange.contains("f"))  // false
