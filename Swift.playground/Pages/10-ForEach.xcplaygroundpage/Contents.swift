import Foundation

// The forEach function is a method that executes a closure on each element
// Unlike for-in loops, forEach cannot use break or continue

let names = ["Alice", "Bob", "Charlie"]

// Basic forEach usage
names.forEach { name in
    print("Hello, \(name)")
}

// forEach with shorthand syntax
names.forEach {
    print("Hi, \($0)")
}

// Using forEach on a range
(1...5).forEach { number in
    print("Number: \(number)")
}

// forEach with dictionaries
let scores = ["Alice": 95, "Bob": 87, "Charlie": 92]

scores.forEach { (name, score) in
    print("\(name) scored \(score)")
}

// forEach with enumerated()
names.enumerated().forEach { (index, name) in
    print("\(index + 1). \(name)")
}

// Note: Unlike for-in loops, you cannot use break or continue in forEach
// If you need early termination, use a for-in loop instead
