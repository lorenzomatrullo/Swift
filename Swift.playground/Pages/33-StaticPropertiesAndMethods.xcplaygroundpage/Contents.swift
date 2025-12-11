import Foundation

// Static properties and methods belong to the type itself,
// not to instances. Access them via the type name.

// STATIC PROPERTIES AND METHODS
struct MathUtility {
    static let pi = 3.14159

    static func celsiusToFahrenheit(_ c: Double) -> Double {
        c * 9/5 + 32
    }
}

print("Pi: \(MathUtility.pi)")
print("77°F = \(MathUtility.celsiusToFahrenheit(25))°F")

// STATIC AS COUNTER
struct User {
    static var userCount = 0
    let id: Int

    init() {
        User.userCount += 1
        self.id = User.userCount
    }
}

let user1 = User()
let user2 = User()
print("\nTotal users: \(User.userCount)")

// SINGLETON PATTERN
class NetworkManager {
    static let shared = NetworkManager()
    private var requestCount = 0

    private init() {}

    func makeRequest() {
        requestCount += 1
        print("Request #\(requestCount)")
    }
}

NetworkManager.shared.makeRequest()
NetworkManager.shared.makeRequest()

// CLASS vs STATIC (classes only)
class Vehicle {
    static func staticMethod() {
        print("Cannot be overridden")
    }

    class func classMethod() {
        print("Can be overridden")
    }
}

class Car: Vehicle {
    override class func classMethod() {
        print("Overridden in subclass")
    }
}

Car.classMethod()
