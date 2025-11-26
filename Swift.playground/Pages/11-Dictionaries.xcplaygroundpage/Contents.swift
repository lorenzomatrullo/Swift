// Chapter 11: Dictionaries

import Foundation

// Dictionaries store key/value pairs, for example [key1: value1, key2: value2]

var scores = ["Richard": 500, "Luke": 400, "Cheryl": 300]
print(scores)

scores["Oli"] = 200
print(scores)

// Updating the value for an existing key
let oldValue = scores.updateValue(100, forKey: "Richard")
print(scores)



// Updating a value and using the previous value if it existed
// "if let" means: if there is a value here, give it a name and run this code.
if let oldValue = scores.updateValue(350, forKey: "Richard") {
    print("Richard's old value was \(oldValue)")
}
print(scores)



// Removing a key/value pair
if let removedValue = scores.removeValue(forKey: "Luke") {
    print("Luke's score was \(removedValue) before he stopped playing")
}
print(scores)



// Accessing the keys and values
let players = Array(scores.keys)
let points = Array(scores.values)
if let richardsScore = scores["Richard"] {
    print(richardsScore)
}
