import Foundation

/*
 FOR LOOP:
    A for loop is a control structure that repeatedly executes a block of code a specific number of times, usually based on a counter or a condition.
*/

for index in 1...5 {
    print("This is number \(index)")
}


// without using parameters
for _ in 1...5 {
    print("Hello")
}


// print arrays
let names = ["John", "Jane", "Jack"]

for name in names {
    print("Hello \(name)")
}


// print each character
for letter in "ABCDEFG" {
    print("The letter is \(letter)")
}


// using two parameters
for (index, letter) in "ABCDEFG".enumerated() {
    print("\(index): \(letter)")
}
// .enumerated() returns a sequence of pairs (index, element) for a collection, allowing you to access both the index and the value of each item in a loop.


//
let vehicles = ["unicycle": 1, "bicycle": 2, "tricycle": 3, "quad bike": 4]

for (vehicleName, wheelCount) in vehicles {
    print("A \(vehicleName) has \(wheelCount) wheels")
}
