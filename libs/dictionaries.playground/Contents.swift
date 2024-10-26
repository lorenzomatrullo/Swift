import Foundation

// scheme:
// [key1: value1, key2: value, ...]

var scores = ["Richard": 500, "Luke": 400, "Cheryl": 300]
print(scores)

scores["Oli"] = 200 // adding al element to the dictionary
print(scores)


// updating the value to a certain key
let oldValue = scores.updateValue(100, forKey: "Richard")
print(scores)


// modify
if let oldValue = scores.updateValue(350, forKey: "Richard") {
    print("Richard's old value was \(oldValue)")
}
print(scores)


// remove
if let removedValue = scores.removeValue(forKey: "Luke") {
    print("Luke's score was \(removedValue) before he stopped playing")
}
print(scores)


// accessing
let players = Array(scores.keys)    // printing only the keys
let points = Array(scores.values)   // printing only the values

if let richardsScore = scores["Richard"] {
    print(richardsScore)
}
