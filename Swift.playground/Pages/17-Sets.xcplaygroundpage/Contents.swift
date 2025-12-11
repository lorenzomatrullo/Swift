import Foundation

// Sets: unordered collections of UNIQUE values.
// Use them when you don't care about order, only about “is this value here or not?”.

// 1. Create a Set. Duplicates are removed automatically.
var colors: Set<String> = ["red", "red", "blue"]
print(colors)          // prints "red" and "blue" once each (order can change)

// 2. Basic operations: add, remove, check, count.
colors.insert("green") // add a value
colors.remove("red")   // remove a value

print(colors.contains("blue")) // true if "blue" is in the set
print(colors.count)            // how many values are in the set

// 3. Simple real-world use: remove duplicates from an array.
let numbersWithDuplicates = [1, 1, 2, 3, 3]
let uniqueNumbers = Set(numbersWithDuplicates)
print(uniqueNumbers)   // {1, 2, 3} in any order


