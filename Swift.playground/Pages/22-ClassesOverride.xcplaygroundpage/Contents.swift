// A subclass can change how a method or property from its base class behaves.

import Foundation

// Base class
class VehicleOverride {
    var currentSpeed = 0.0
    
    var description: String {
        "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // Default implementation does nothing
    }
}

// This subclass changes (overrides) how makeNoise() works.
class Train: VehicleOverride {
    override func makeNoise() {
        print("Choo Choo!")
    }
}

// This subclass adds a new stored property and also overrides description.
class Car: VehicleOverride {
    var gear = 1
    
    override var description: String {
        // super.description means "use the description from VehicleOverride"
        // and then add more information for Car.
        super.description + " in gear \(gear)"
    }
}

 

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Student: Person {
    var favoriteSubject: String
    
    init(name: String, favoriteSubject: String) {
        self.favoriteSubject = favoriteSubject
        // super.init calls the init from Person so the name property is set there.
        super.init(name: name)
    }
}

let train = Train()
train.makeNoise()

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
