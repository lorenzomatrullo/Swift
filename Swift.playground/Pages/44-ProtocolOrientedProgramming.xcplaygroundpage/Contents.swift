import Foundation

// Protocol-Oriented Programming (POP) is a paradigm that favors protocols
// and protocol extensions over class inheritance.
// Apple recommends "Don't start with a class, start with a protocol."

// PROTOCOL EXTENSIONS
// You can add default implementations to protocols
protocol Identifiable {
    var id: String { get }
}

extension Identifiable {
    // Default implementation
    func displayID() {
        print("ID: \(id)")
    }
}

struct User: Identifiable {
    let id: String
    let name: String
}

struct Product: Identifiable {
    let id: String
    let price: Double
}

let user = User(id: "U123", name: "Alice")
let product = Product(id: "P456", price: 99.99)

user.displayID()
product.displayID()

// PROTOCOL COMPOSITION
// Combine multiple protocols using &
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("\nHappy birthday, \(celebrator.name)! You're now \(celebrator.age)!")
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

let person = Person(name: "Bob", age: 30)
wishHappyBirthday(to: person)

// PROTOCOL INHERITANCE
protocol Printable {
    func printDescription()
}

protocol PrettyPrintable: Printable {
    func printPretty()
}

struct Document: PrettyPrintable {
    let title: String
    let content: String

    func printDescription() {
        print("\n\(title): \(content)")
    }

    func printPretty() {
        print("\n╔═══════════════════╗")
        print("║ \(title)")
        print("╠═══════════════════╣")
        print("║ \(content)")
        print("╚═══════════════════╝")
    }
}

let doc = Document(title: "Swift Guide", content: "Learn POP")
doc.printPretty()

// PROTOCOL-ORIENTED DESIGN PATTERN
// Instead of inheritance, use protocol composition

protocol Drawable {
    func draw()
}

protocol Transformable {
    mutating func move(x: Double, y: Double)
    mutating func scale(by factor: Double)
}

struct Circle: Drawable, Transformable {
    var centerX: Double
    var centerY: Double
    var radius: Double

    func draw() {
        print("\nDrawing circle at (\(centerX), \(centerY)) with radius \(radius)")
    }

    mutating func move(x: Double, y: Double) {
        centerX += x
        centerY += y
        print("Circle moved to (\(centerX), \(centerY))")
    }

    mutating func scale(by factor: Double) {
        radius *= factor
        print("Circle scaled to radius \(radius)")
    }
}

var circle = Circle(centerX: 0, centerY: 0, radius: 5)
circle.draw()
circle.move(x: 10, y: 20)
circle.scale(by: 2)

// PROTOCOL EXTENSIONS WITH CONSTRAINTS
protocol Container {
    associatedtype Item
    var count: Int { get }
    mutating func append(_ item: Item)
}

extension Container where Item: Equatable {
    func contains(_ item: Item) -> Bool {
        for i in 0..<count {
            // This would need actual implementation with subscript
            // Simplified for demonstration
            return false
        }
        return false
    }
}

// VALUE SEMANTICS WITH PROTOCOLS
// Protocols work great with structs (value types)

protocol Copyable {
    func copy() -> Self
}

struct Point: Copyable {
    var x: Int
    var y: Int

    func copy() -> Point {
        return Point(x: x, y: y)
    }
}

let point1 = Point(x: 10, y: 20)
let point2 = point1.copy()
print("\nPoint 1: (\(point1.x), \(point1.y))")
print("Point 2: (\(point2.x), \(point2.y))")

// PROTOCOL-BASED POLYMORPHISM
protocol Animal {
    var name: String { get }
    func makeSound()
}

struct Dog: Animal {
    var name: String

    func makeSound() {
        print("\(name) says: Woof!")
    }
}

struct Cat: Animal {
    var name: String

    func makeSound() {
        print("\(name) says: Meow!")
    }
}

struct Bird: Animal {
    var name: String

    func makeSound() {
        print("\(name) says: Tweet!")
    }
}

let animals: [Animal] = [
    Dog(name: "Rex"),
    Cat(name: "Whiskers"),
    Bird(name: "Tweety")
]

print()
for animal in animals {
    animal.makeSound()
}

// PROTOCOL WITH ASSOCIATED TYPES
protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
}

struct IntQueue: Queue {
    typealias Element = Int
    private var items: [Int] = []

    mutating func enqueue(_ element: Int) {
        items.append(element)
    }

    mutating func dequeue() -> Int? {
        return isEmpty ? nil : items.removeFirst()
    }

    var isEmpty: Bool {
        return items.isEmpty
    }
}

var queue = IntQueue()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)

print("\nDequeuing:")
while let item = queue.dequeue() {
    print(item)
}

// PROTOCOL EXTENSIONS FOR COLLECTIONS
extension Collection where Element: Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

let numbers = [1, 2, 3, 4, 5]
print("\nSum: \(numbers.sum())")

let doubles = [1.5, 2.5, 3.5]
print("Sum: \(doubles.sum())")

// PRACTICAL EXAMPLE: Validator Protocol
protocol Validator {
    associatedtype Value
    func validate(_ value: Value) -> Bool
    func errorMessage() -> String
}

extension Validator {
    func errorMessage() -> String {
        return "Validation failed"
    }
}

struct EmailValidator: Validator {
    func validate(_ value: String) -> Bool {
        return value.contains("@") && value.contains(".")
    }

    func errorMessage() -> String {
        return "Invalid email format"
    }
}

struct PasswordValidator: Validator {
    let minLength: Int

    func validate(_ value: String) -> Bool {
        return value.count >= minLength
    }

    func errorMessage() -> String {
        return "Password must be at least \(minLength) characters"
    }
}

let emailValidator = EmailValidator()
let passwordValidator = PasswordValidator(minLength: 8)

print("\nValidating email:")
let email = "test@example.com"
if emailValidator.validate(email) {
    print("✓ Valid email")
} else {
    print("✗ \(emailValidator.errorMessage())")
}

print("\nValidating password:")
let password = "short"
if passwordValidator.validate(password) {
    print("✓ Valid password")
} else {
    print("✗ \(passwordValidator.errorMessage())")
}

// PROTOCOL-ORIENTED NETWORKING
protocol APIRequest {
    associatedtype Response
    var endpoint: String { get }
    func parse(_ data: Data) -> Response?
}

extension APIRequest {
    func execute(completion: @escaping (Response?) -> Void) {
        print("\nFetching from \(endpoint)...")
        // Simulated network call
        completion(nil)
    }
}

struct UserRequest: APIRequest {
    typealias Response = User

    var endpoint: String {
        return "/api/users"
    }

    func parse(_ data: Data) -> User? {
        // Parse JSON data to User
        return nil
    }
}

// ADVANTAGES OF PROTOCOL-ORIENTED PROGRAMMING:
// 1. Value semantics (works with structs)
// 2. No inheritance chains
// 3. Multiple protocol conformance (unlike single inheritance)
// 4. Retroactive modeling (extend existing types)
// 5. Better testability (easy to mock protocols)
// 6. More flexible composition

// POP vs OOP:
// OOP: Start with base classes, use inheritance
// POP: Start with protocols, use composition
// Result: More flexible, maintainable, and Swift-like code

print("\nProtocol-Oriented Programming encourages composition over inheritance!")
