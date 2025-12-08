import Foundation

// Lazy properties are only calculated when first accessed.
// They must be variables (var), not constants (let).
// Use lazy for expensive computations or when a property depends on
// values that aren't known until after initialization.

// BASIC LAZY PROPERTY
class DataManager {
    lazy var expensiveData: [String] = {
        print("Computing expensive data...")
        // Simulate expensive operation
        return (1...1000).map { "Item \($0)" }
    }()

    init() {
        print("DataManager initialized")
    }
}

let manager = DataManager()
print("Manager created, but expensiveData not computed yet")
print("\nAccessing expensiveData for the first time:")
let data = manager.expensiveData
print("Data count: \(data.count)")
print("\nAccessing expensiveData again:")
let dataAgain = manager.expensiveData  // No recomputation
print("Data count: \(dataAgain.count)")

// LAZY WITH COMPLEX INITIALIZATION
struct ImageProcessor {
    let imageName: String

    lazy var processedImage: String = {
        print("Processing image: \(imageName)")
        // Simulate image processing
        Thread.sleep(forTimeInterval: 0.1)
        return "\(imageName)_processed"
    }()

    lazy var thumbnail: String = {
        print("Creating thumbnail for: \(imageName)")
        return "\(imageName)_thumb"
    }()

    init(imageName: String) {
        self.imageName = imageName
        print("ImageProcessor initialized with: \(imageName)")
    }
}

var processor = ImageProcessor(imageName: "photo.jpg")
print("Processor created\n")

// Only processedImage is computed when accessed
print("Getting processed image:")
print(processor.processedImage)

print("\nGetting thumbnail:")
print(processor.thumbnail)

// LAZY PROPERTY DEPENDING ON OTHER PROPERTIES
class Person {
    let firstName: String
    let lastName: String

    // Lazy property that uses other properties
    lazy var fullName: String = {
        print("Computing full name...")
        return "\(self.firstName) \(self.lastName)"
    }()

    lazy var initials: String = {
        let first = self.firstName.prefix(1)
        let last = self.lastName.prefix(1)
        return "\(first).\(last)."
    }()

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let person = Person(firstName: "John", lastName: "Doe")
print("\nPerson created")
print("Accessing full name: \(person.fullName)")
print("Accessing initials: \(person.initials)")

// LAZY WITH CLOSURE CAPTURING SELF
class FileReader {
    let filename: String

    lazy var contents: String = {
        print("Reading file: \(self.filename)")
        // In real code, this would read from file
        return "Contents of \(self.filename)"
    }()

    lazy var lineCount: Int = {
        return self.contents.components(separatedBy: "\n").count
    }()

    init(filename: String) {
        self.filename = filename
    }
}

let reader = FileReader(filename: "data.txt")
print("\nFileReader created")
print("Line count: \(reader.lineCount)")  // Triggers both contents and lineCount

// PRACTICAL EXAMPLE: Database connection
class Database {
    let connectionString: String

    lazy var connection: String = {
        print("Establishing database connection...")
        // Simulate connection delay
        Thread.sleep(forTimeInterval: 0.2)
        print("Connected to: \(self.connectionString)")
        return "Connection to \(self.connectionString)"
    }()

    init(connectionString: String) {
        self.connectionString = connectionString
        print("Database object created (not connected yet)")
    }

    func executeQuery(_ query: String) {
        // Connection only established when needed
        print("\nUsing: \(connection)")
        print("Executing: \(query)")
    }
}

let db = Database(connectionString: "localhost:5432")
print("Database object exists but no connection yet\n")

db.executeQuery("SELECT * FROM users")

// LAZY VS NON-LAZY COMPARISON
class WithoutLazy {
    var heavyComputation: [Int] = {
        print("Without lazy: Computing immediately")
        return Array(1...10000)
    }()

    init() {
        print("WithoutLazy initialized")
    }
}

class WithLazy {
    lazy var heavyComputation: [Int] = {
        print("With lazy: Computing on first access")
        return Array(1...10000)
    }()

    init() {
        print("WithLazy initialized")
    }
}

print("\n--- Creating WithoutLazy ---")
let withoutLazy = WithoutLazy()
print("Object created\n")

print("--- Creating WithLazy ---")
let withLazy = WithLazy()
print("Object created (computation not done yet)")
print("Accessing lazy property:")
_ = withLazy.heavyComputation

// IMPORTANT NOTES:
// 1. Lazy properties are NOT thread-safe
// 2. Can only be used with var, not let
// 3. Cannot be used with stored property observers (willSet/didSet)
// 4. Computed once and cached - not recomputed on subsequent access

struct Notes {
    // ❌ This won't compile:
    // lazy let value = 42  // Error: lazy cannot be used with 'let'

    // ✅ This works:
    lazy var value: Int = {
        return 42
    }()

    // ❌ This won't compile:
    // lazy var observed: Int = 42 {
    //     willSet { print("will set") }
    // }
}
