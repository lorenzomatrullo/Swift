import Foundation

// Static properties and methods belong to the type itself,
// not to instances of the type.
// Use 'static' for structs and enums, 'class' or 'static' for classes.

// STATIC PROPERTIES IN STRUCTS
struct MathUtility {
    static let pi = 3.14159
    static let e = 2.71828

    static var version: String {
        return "1.0.0"
    }
}

// Access static properties through the type name, not an instance
print("Pi: \(MathUtility.pi)")
print("E: \(MathUtility.e)")
print("Version: \(MathUtility.version)")

// STATIC METHODS IN STRUCTS
struct Temperature {
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return celsius * 9/5 + 32
    }

    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
}

print("\n25°C = \(Temperature.celsiusToFahrenheit(25))°F")
print("77°F = \(Temperature.fahrenheitToCelsius(77))°C")

// STATIC PROPERTIES AS COUNTERS
struct User {
    static var userCount = 0

    let id: Int
    let name: String

    init(name: String) {
        User.userCount += 1
        self.id = User.userCount
        self.name = name
    }

    func displayInfo() {
        print("User #\(id): \(name)")
        print("Total users: \(User.userCount)")
    }
}

let user1 = User(name: "Alice")
let user2 = User(name: "Bob")
let user3 = User(name: "Charlie")

user3.displayInfo()

// STATIC METHODS ACCESSING STATIC PROPERTIES
struct AppConfig {
    static var appName = "MyApp"
    static var version = "1.0"

    static func getFullVersion() -> String {
        return "\(appName) v\(version)"
    }

    static func updateVersion(to newVersion: String) {
        version = newVersion
    }
}

print("\n\(AppConfig.getFullVersion())")
AppConfig.updateVersion(to: "2.0")
print(AppConfig.getFullVersion())

// STATIC VS INSTANCE
struct Calculator {
    var currentValue: Int

    // Instance method - works with instance data
    mutating func add(_ value: Int) {
        currentValue += value
    }

    // Static method - no access to instance data
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}

var calc = Calculator(currentValue: 10)
calc.add(5)
print("\nInstance value: \(calc.currentValue)")

let sum = Calculator.add(3, 7)
print("Static calculation: \(sum)")

// STATIC PROPERTIES IN CLASSES
class DatabaseConnection {
    static var connectionCount = 0
    static var maxConnections = 5

    static func canConnect() -> Bool {
        return connectionCount < maxConnections
    }

    let id: Int

    init?() {
        guard DatabaseConnection.canConnect() else {
            print("Max connections reached")
            return nil
        }

        DatabaseConnection.connectionCount += 1
        self.id = DatabaseConnection.connectionCount
        print("Connection \(id) established")
    }

    deinit {
        DatabaseConnection.connectionCount -= 1
        print("Connection \(id) closed")
    }
}

var connections: [DatabaseConnection] = []
for _ in 1...6 {
    if let connection = DatabaseConnection() {
        connections.append(connection)
    }
}

print("\nActive connections: \(DatabaseConnection.connectionCount)")

// CLASS vs STATIC IN CLASSES
class Vehicle {
    // 'static' cannot be overridden
    static func staticMethod() {
        print("Vehicle static method")
    }

    // 'class' can be overridden by subclasses
    class func classMethod() {
        print("Vehicle class method")
    }
}

class Car: Vehicle {
    // Cannot override static method
    // override static func staticMethod() { }  // Error!

    // Can override class method
    override class func classMethod() {
        print("Car class method (overridden)")
    }
}

Vehicle.staticMethod()
Vehicle.classMethod()
Car.classMethod()  // Calls overridden version

// PRACTICAL EXAMPLE: Factory pattern
struct Color {
    let red: Double
    let green: Double
    let blue: Double

    // Static factory methods for common colors
    static var black: Color {
        return Color(red: 0, green: 0, blue: 0)
    }

    static var white: Color {
        return Color(red: 1, green: 1, blue: 1)
    }

    static var red: Color {
        return Color(red: 1, green: 0, blue: 0)
    }

    static func custom(red: Double, green: Double, blue: Double) -> Color {
        return Color(red: red, green: green, blue: blue)
    }
}

let backgroundColor = Color.white
let textColor = Color.black
let customColor = Color.custom(red: 0.5, green: 0.3, blue: 0.8)

print("\nBackground: R:\(backgroundColor.red) G:\(backgroundColor.green) B:\(backgroundColor.blue)")

// STATIC COMPUTED PROPERTIES
struct FileManager {
    static var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }

    static var cachePath: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
}

print("\nDocuments: \(FileManager.documentsPath)")
print("Cache: \(FileManager.cachePath)")

// SINGLETON PATTERN USING STATIC
class NetworkManager {
    // Shared instance (singleton)
    static let shared = NetworkManager()

    private var requestCount = 0

    // Private initializer prevents creating additional instances
    private init() {
        print("NetworkManager singleton created")
    }

    func makeRequest() {
        requestCount += 1
        print("Request #\(requestCount)")
    }
}

// All code uses the same shared instance
NetworkManager.shared.makeRequest()
NetworkManager.shared.makeRequest()
NetworkManager.shared.makeRequest()

// STATIC STORED PROPERTIES ARE LAZY BY DEFAULT
struct HeavyComputation {
    static var expensiveValue: [Int] = {
        print("Computing expensive static value...")
        return Array(1...10000)
    }()
}

print("\nBefore accessing static property")
let value = HeavyComputation.expensiveValue.count
print("Value: \(value)")
