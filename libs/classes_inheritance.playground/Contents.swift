import Foundation

// base class
class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {
        "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}


// sub-class
class Bicycle: Vehicle {
    var hasBasket = false
}

// sub-class of a sub-class
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}


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
