import Foundation

// A Set stores unique values of the same type in an unordered collection.
// Sets are useful when order doesn't matter or when you need to ensure uniqueness.

// CREATING SETS
var colors: Set<String> = ["red", "green", "blue"]
print(colors)  // Order may vary: ["green", "blue", "red"]

// Empty set
var emptySet = Set<Int>()
var anotherEmpty: Set<String> = []

// Sets automatically remove duplicates
var numbers: Set = [1, 2, 3, 2, 1, 4]
print(numbers)  // [1, 2, 3, 4] - duplicates removed

// BASIC OPERATIONS
print(colors.count)     // 3
print(colors.isEmpty)   // false

// Adding elements
colors.insert("yellow")
print(colors)

// Removing elements
colors.remove("red")
print(colors)

// Check if an element exists (very fast - O(1) operation)
if colors.contains("blue") {
    print("Blue is in the set")
}

// Iterating over a set (order is not guaranteed)
for color in colors {
    print(color)
}

// Iterate in sorted order
for color in colors.sorted() {
    print(color)
}

// SET OPERATIONS
let oddNumbers: Set = [1, 3, 5, 7, 9]
let evenNumbers: Set = [0, 2, 4, 6, 8]
let primeNumbers: Set = [2, 3, 5, 7]

// Union: combines all unique elements from both sets
let unionSet = oddNumbers.union(evenNumbers)
print("Union: \(unionSet.sorted())")  // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

// Intersection: elements that appear in both sets
let intersectionSet = oddNumbers.intersection(primeNumbers)
print("Intersection: \(intersectionSet.sorted())")  // [3, 5, 7]

// Subtracting: elements in first set but not in second
let subtractSet = oddNumbers.subtracting(primeNumbers)
print("Subtracting: \(subtractSet.sorted())")  // [1, 9]

// Symmetric difference: elements in either set, but not both
let symmetricSet = oddNumbers.symmetricDifference(primeNumbers)
print("Symmetric Difference: \(symmetricSet.sorted())")  // [1, 2, 9]

// SET MEMBERSHIP AND EQUALITY
let animals: Set = ["dog", "cat", "bird"]
let pets: Set = ["dog", "cat", "bird", "fish"]
let farmAnimals: Set = ["cow", "chicken", "pig"]

// Equality
print(animals == pets)  // false

// Subset: all elements of first set are in second set
print(animals.isSubset(of: pets))  // true

// Superset: first set contains all elements of second set
print(pets.isSuperset(of: animals))  // true

// Disjoint: sets have no elements in common
print(animals.isDisjoint(with: farmAnimals))  // true

// PRACTICAL USE CASE: removing duplicates from an array
let numbersWithDuplicates = [1, 2, 3, 2, 4, 1, 5, 3]
let uniqueNumbers = Set(numbersWithDuplicates)
let sortedUnique = uniqueNumbers.sorted()
print("Unique sorted numbers: \(sortedUnique)")
