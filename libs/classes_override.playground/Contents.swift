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


class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo!")
    }
}

class Car: Vehicle {
    var gear = 1
    
    override var description: String {
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
        super.init(name: name)
    }
}



let train = Train()
train.makeNoise()


let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
