// Chapter 10: Arrays

import Foundation

let myName = "Lorenzo"
let yourName = "Foo"
var allInOne = ["Lorenzo", "Foo"]

allInOne.append("Vuitton")
allInOne += ["Jordan"]
print(allInOne)

allInOne.insert("Bob", at: 0)
print(allInOne)

allInOne.remove(at: 2)
allInOne.removeLast()
allInOne.removeAll()

// Concatenating arrays
var firstArray = ["One", "Two"]
var secondArray = ["Three", "Four"]
var sumArray = firstArray + secondArray
print(sumArray)

// Arrays that contain other arrays
let array1 = [1, 2, 3]
let array2 = [4, 5, 6]
let containerArray = [array1, array2]
let oneArray = containerArray[0]
let firstElement = containerArray[0][0]
print(containerArray)
print(oneArray)
print(firstElement)

// Checking whether an array contains a value
let numbers = [4, 5, 6]
if numbers.contains(5) {
    print("There is a 5")
}

// Checking whether an array is empty
if numbers.isEmpty {
    print("Nothing is in the array")
}

// Accessing an element by index
var names = ["Anne", "Gary", "Keith"]
let firstName = names[0]
print(firstName)
