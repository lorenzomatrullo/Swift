// Chapter 16: Mutating methods in structs

import Foundation

// A mutating method is allowed to change the stored properties of a struct.
// Without "mutating", methods in a struct are read-only.
struct Odometer {
    var count: Int = 0
    
    mutating func increment() {
        count += 1
    }
    
    // "by amount" means:
    // - "by" is the label you write when calling the function
    // - "amount" is the name you use inside the function
    mutating func increment(by amount: Int) {
        count += amount
    }
    
    mutating func reset() {
        count = 0
    }
}

var odometer = Odometer()
odometer.increment()
odometer.increment(by: 15)
odometer.reset()
