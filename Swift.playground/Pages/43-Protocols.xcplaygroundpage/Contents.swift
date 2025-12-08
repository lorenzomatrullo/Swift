import Foundation

// A protocol describes a set of requirements that types can adopt.
protocol Drivable {
    func drive()
}

struct Car: Drivable {
    func drive() {
        print("The car is driving")
    }
}

let myCar = Car()
myCar.drive()
