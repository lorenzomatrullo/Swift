import Foundation

// Optional chaining is a process for querying and calling properties,
// methods, and subscripts on an optional that might be nil.
// If the optional contains a value, the operation succeeds.
// If the optional is nil, the operation returns nil.

// BASIC OPTIONAL CHAINING
// Use ? after an optional to safely access its properties or methods
class Person {
    var name: String
    var residence: Residence?

    init(name: String) {
        self.name = name
    }
}

class Residence {
    var address: Address?
    var numberOfRooms: Int = 1
}

class Address {
    var street: String = ""
    var city: String = ""
    var postalCode: String = ""
}

let john = Person(name: "John")

// Without optional chaining (this would crash if residence is nil):
// let roomCount = john.residence!.numberOfRooms  // CRASH!

// With optional chaining (safely returns nil if residence is nil):
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve room count")
}

// CHAINING MULTIPLE LEVELS
// You can chain through multiple optional properties
let street = john.residence?.address?.street
print(type(of: street))  // Optional<String>

if let johnStreet = john.residence?.address?.street {
    print("John lives on \(johnStreet)")
} else {
    print("Street information unavailable")
}

// SETTING UP A VALID CHAIN
john.residence = Residence()
john.residence?.address = Address()
john.residence?.address?.street = "123 Swift Lane"
john.residence?.address?.city = "Cupertino"

// Now the chain works
if let street = john.residence?.address?.street {
    print("John lives on \(street)")
}

// CALLING METHODS THROUGH OPTIONAL CHAINING
class BankAccount {
    var balance: Double

    init(balance: Double) {
        self.balance = balance
    }

    func deposit(amount: Double) {
        balance += amount
        print("Deposited $\(amount). New balance: $\(balance)")
    }
}

class Customer {
    var name: String
    var account: BankAccount?

    init(name: String) {
        self.name = name
    }
}

let alice = Customer(name: "Alice")

// Calling method through optional chaining
alice.account?.deposit(amount: 100)  // Does nothing, no output

// After setting up the account
alice.account = BankAccount(balance: 500)
alice.account?.deposit(amount: 100)  // Works!

// ACCESSING SUBSCRIPTS THROUGH OPTIONAL CHAINING
var scores: [String: Int]? = ["Math": 95, "English": 88]

// Accessing dictionary subscript through optional chaining
if let mathScore = scores?["Math"] {
    print("Math score: \(mathScore)")
}

scores = nil
let englishScore = scores?["English"]  // Returns nil

// CHAINING WITH ARRAYS
class Library {
    var books: [String]?
}

let library = Library()
library.books = ["1984", "Brave New World", "Fahrenheit 451"]

// Accessing array subscript through optional chaining
if let firstBook = library.books?[0] {
    print("First book: \(firstBook)")
}

// CHECKING FOR SUCCESS
// When calling a method through optional chaining,
// you can check if the call succeeded by comparing to nil
func canDeposit(to customer: Customer?, amount: Double) -> Bool {
    // The return type becomes Void? (optional Void)
    return customer?.account?.deposit(amount: amount) != nil
}

print("Can deposit: \(canDeposit(to: alice, amount: 50))")

// OPTIONAL CHAINING WITH COMPUTED PROPERTIES
class Rectangle {
    var width: Double
    var height: Double

    var area: Double {
        return width * height
    }

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

var rectangle: Rectangle? = Rectangle(width: 10, height: 5)
if let area = rectangle?.area {
    print("Area: \(area)")
}

// COMBINING WITH NIL COALESCING (preview - covered in next lesson)
let defaultStreet = john.residence?.address?.street ?? "Unknown Street"
print("Street: \(defaultStreet)")

// PRACTICAL EXAMPLE: Safely navigating nested JSON-like structures
struct Response {
    var data: DataContainer?
}

struct DataContainer {
    var user: User?
}

struct User {
    var profile: Profile?
}

struct Profile {
    var displayName: String?
}

let response = Response(data: DataContainer(user: User(profile: Profile(displayName: "SwiftCoder"))))

// Safe chain through multiple optionals
if let name = response.data?.user?.profile?.displayName {
    print("User display name: \(name)")
}
