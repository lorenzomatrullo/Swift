import Foundation

// Using enumerated() to get both index and value
let names = ["Alice", "Bob", "Charlie"]

for (index, name) in names.enumerated() {
    print("\(index): \(name)")
}

// Accessing both the index and the value from a string
for (index, letter) in "ABCDEFG".enumerated() {
    print("Index \(index) has letter \(letter)")
}

// Using enumeration with dictionaries
let scores = ["Alice": 95, "Bob": 87, "Charlie": 92]

for (index, (name, score)) in scores.enumerated() {
    print("Entry \(index): \(name) scored \(score)")
}

// Starting enumeration from a different index
for (index, name) in names.enumerated().map({ ($0.offset + 1, $0.element) }) {
    print("Person #\(index): \(name)")
}
