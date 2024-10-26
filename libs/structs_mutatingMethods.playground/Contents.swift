import Foundation

/*
 MUTATING FUNCTIONS:
    Mutating functions are methods in Swift structs that can modify the struct's properties, allowing changes to its state.
*/


struct Odometer {
    var count: Int = 0
    
    mutating func increment() {
        count += 1
    }
    
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
