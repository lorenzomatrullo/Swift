import Foundation

// For-in loop over a range
for index in 1...5 {
    print("This is number \(index)")
}

// Repeating work when you do not need the loop value
for _ in 1...5 {
    print("Hello")
}

// Looping through all elements in an array
let names = ["John", "Jane", "Jack"]

for name in names {
    print("Hello \(name)")
}

// Looping through all characters in a string
for letter in "ABCDEFG" {
    print("The letter is \(letter)")
}

// Accessing both the index and the value
for (index, letter) in "ABCDEFG".enumerated() {
    print("\(index): \(letter)")
}

// Iterating over key/value pairs in a dictionary
let vehicles = ["unicycle": 1, "bicycle": 2, "tricycle": 3, "quad bike": 4]

for (vehicleName, wheelCount) in vehicles {
    print("A \(vehicleName) has \(wheelCount) wheels")
}
