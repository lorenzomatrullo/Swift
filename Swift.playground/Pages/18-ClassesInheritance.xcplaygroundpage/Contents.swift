// Chapter 20: Class inheritance
// Inheritance means: one class builds on another and automatically
// gets its stored properties and methods.

import Foundation

// Base class: a general "vehicle" that others can reuse.
class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {
        "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // Default implementation does nothing
    }
}

// Subclass: Bicycle "is a" Vehicle, but with extra data.
class Bicycle: Vehicle {
    var hasBasket = false
}

// Subclass of a subclass: Tandem "is a" Bicycle that can carry more people.
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

// Each instance below inherits the behavior from Vehicle.
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
