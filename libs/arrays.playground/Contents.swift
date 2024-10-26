import Foundation

let myName = "Lorenzo"
let yourName = "Foo"
var allInOne = ["Lorenzo", "Foo"]

allInOne.append("Vuitton")      // add an element at the end of the array
allInOne += ["Jordan"]          // another way
print(allInOne)

allInOne.insert("Bob", at: 0)   // adding elements specifing the position
print(allInOne)

allInOne.remove(at: 2)          // removing elements at a desired position
allInOne.removeLast()           // removing last element from the array
allInOne.removeAll()            // remove all the elements from the array


// sum of arrays
var firstArray = ["One", "Two"]
var secondArray = ["Three", "Four"]
var sumArray = firstArray + secondArray
print(sumArray)


// arrays with arrays
let array1 = [1, 2, 3]
let array2 = [4, 5, 6]
let containerArray = [array1, array2]
let OneArray = containerArray[0]
let firstElement = containerArray[0][0]
print(containerArray)
print(OneArray)
print(firstElement)


// contains method
let numbers = [4, 5, 6]
if numbers.contains(5) {
    print("There is a 5")
}

// isEmpty method
if numbers.isEmpty {
    print("Nothing is in the array")
}


// accessing a specific item
var names = ["Anne", "Gary", "Keith"]
let firstName = names[0]
print(firstName)
