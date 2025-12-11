import Foundation

// Lazy properties are calculated only when first accessed.
// Use them for expensive operations that may not be needed.

// BASIC LAZY PROPERTY
class DataManager {
    lazy var expensiveData: [String] = {
        print("Computing...")
        return (1...1000).map { "Item \($0)" }
    }()
}

let manager = DataManager()
print("Manager created (data not computed yet)")
print("Count: \(manager.expensiveData.count)")  // Now computed
print("Count: \(manager.expensiveData.count)")  // Reuses cached value

// LAZY PROPERTY DEPENDING ON OTHER PROPERTIES
class Person {
    let firstName: String
    let lastName: String

    lazy var fullName: String = {
        "\(self.firstName) \(self.lastName)"
    }()

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let person = Person(firstName: "John", lastName: "Doe")
print("\nFull name: \(person.fullName)")

// PRACTICAL EXAMPLE
class Database {
    let connectionString: String

    lazy var connection: String = {
        print("Connecting to database...")
        return "Connected to \(self.connectionString)"
    }()

    init(connectionString: String) {
        self.connectionString = connectionString
    }

    func executeQuery(_ query: String) {
        print(connection)  // Connection established on first query
        print("Executing: \(query)")
    }
}

let db = Database(connectionString: "localhost:5432")
db.executeQuery("SELECT * FROM users")

// Note: Lazy properties must be var, not let
