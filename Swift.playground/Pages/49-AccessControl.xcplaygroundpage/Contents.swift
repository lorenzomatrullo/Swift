import Foundation

// Access control restricts access to parts of your code from code in other files or modules.
// Swift has five access levels: open, public, internal, fileprivate, and private.

// ACCESS LEVELS (from most to least accessible):
// 1. open      - Accessible everywhere, can be subclassed/overridden outside module
// 2. public    - Accessible everywhere, but cannot be subclassed outside module
// 3. internal  - Accessible within the same module (default level)
// 4. fileprivate - Accessible only within the same source file
// 5. private   - Accessible only within the enclosing declaration

// PRIVATE ACCESS
// Only accessible within the same type/scope
struct BankAccount {
    private var balance: Double = 0.0

    // Public methods to interact with private property
    mutating func deposit(_ amount: Double) {
        guard amount > 0 else { return }
        balance += amount
        print("Deposited $\(amount). Balance: $\(balance)")
    }

    mutating func withdraw(_ amount: Double) -> Bool {
        guard amount > 0 && amount <= balance else {
            print("Withdrawal failed")
            return false
        }
        balance -= amount
        print("Withdrew $\(amount). Balance: $\(balance)")
        return true
    }

    func getBalance() -> Double {
        return balance
    }
}

var account = BankAccount()
account.deposit(100)
account.withdraw(30)
print("Current balance: $\(account.getBalance())")
// account.balance = 1000  // Error: 'balance' is private

// PRIVATE(SET) - Read publicly, write privately
struct Person {
    private(set) var age: Int  // Can be read publicly, but only set internally

    init(age: Int) {
        self.age = age
    }

    mutating func haveBirthday() {
        age += 1
        print("Happy birthday! Now \(age) years old.")
    }
}

var person = Person(age: 25)
print("Age: \(person.age)")  // Can read
person.haveBirthday()
// person.age = 30  // Error: Cannot assign to property, setter is private

// FILEPRIVATE ACCESS
// Accessible within the same file (useful for helper functions/extensions)
fileprivate func helperFunction() {
    print("This function is accessible only in this file")
}

struct DataProcessor {
    fileprivate var data: [String] = []

    func processData() {
        helperFunction()  // Can access fileprivate function in same file
        print("Processing: \(data)")
    }
}

// INTERNAL ACCESS (default)
// Accessible within the same module
struct InternalStruct {
    var property: String = "Internal"  // internal by default

    func method() {
        print("Internal method")
    }
}

let internalInstance = InternalStruct()
print(internalInstance.property)

// PUBLIC ACCESS
// Accessible from other modules
public struct PublicStruct {
    public var name: String

    public init(name: String) {
        self.name = name
    }

    public func display() {
        print("Public: \(name)")
    }

    // Can mix access levels
    private var secretData: String = "secret"
}

// PRACTICAL EXAMPLE: User authentication
public class User {
    public let username: String
    private var passwordHash: String

    // Public initializer
    public init(username: String, password: String) {
        self.username = username
        self.passwordHash = String(password.hashValue)
    }

    // Public method using private property
    public func authenticate(password: String) -> Bool {
        return String(password.hashValue) == passwordHash
    }

    // Private method
    private func generateToken() -> String {
        return UUID().uuidString
    }

    // Public method using private method
    public func login(password: String) -> String? {
        guard authenticate(password: password) else {
            return nil
        }
        return generateToken()
    }
}

let user = User(username: "alice", password: "secret123")
print("\nUsername: \(user.username)")
// print(user.passwordHash)  // Error: 'passwordHash' is private

if let token = user.login(password: "secret123") {
    print("Login successful! Token: \(token)")
}

// ACCESS CONTROL WITH COMPUTED PROPERTIES
struct Rectangle {
    private var width: Double
    private var height: Double

    // Public computed property
    public var area: Double {
        return width * height
    }

    // Different access levels for getter and setter
    public private(set) var perimeter: Double {
        get {
            return 2 * (width + height)
        }
        set {
            // Calculate new dimensions
            let ratio = width / height
            height = newValue / (2 * (1 + ratio))
            width = height * ratio
        }
    }

    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

var rect = Rectangle(width: 10, height: 5)
print("\nArea: \(rect.area)")
print("Perimeter: \(rect.perimeter)")

// ACCESS CONTROL IN INHERITANCE
public class Vehicle {
    private var speed: Double = 0

    // Protected-like pattern (fileprivate allows subclasses in same file)
    fileprivate func setSpeed(_ newSpeed: Double) {
        speed = newSpeed
    }

    public func getSpeed() -> Double {
        return speed
    }
}

public class Car: Vehicle {
    public func accelerate() {
        setSpeed(getSpeed() + 10)  // Can access fileprivate method
        print("Speed: \(getSpeed()) mph")
    }
}

let car = Car()
car.accelerate()
// car.setSpeed(50)  // Error if in different file

// ACCESS CONTROL WITH PROTOCOLS
public protocol Drawable {
    func draw()
}

// Private struct conforming to public protocol
private struct Circle: Drawable {
    var radius: Double

    func draw() {
        print("Drawing circle with radius \(radius)")
    }
}

// Factory function returns protocol type
public func createShape() -> Drawable {
    return Circle(radius: 5.0)
}

let shape = createShape()
shape.draw()
// let circle = shape as? Circle  // Cannot access private type

// NESTED TYPES ACCESS CONTROL
public struct OuterStruct {
    private struct InnerStruct {
        var value: Int
    }

    private var inner = InnerStruct(value: 42)

    public func getValue() -> Int {
        return inner.value
    }
}

let outer = OuterStruct()
print("\nValue from nested type: \(outer.getValue())")

// GUIDELINES:
// 1. Use private by default, expose only what's necessary
// 2. Use private(set) for properties that should be readable but not writable externally
// 3. Use fileprivate for helper functions/extensions in the same file
// 4. Internal is the default and works well for most cases
// 5. Use public for API boundaries (frameworks, libraries)
// 6. Use open only for classes meant to be subclassed outside the module
