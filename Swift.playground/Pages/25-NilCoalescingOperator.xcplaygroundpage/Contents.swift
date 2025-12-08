import Foundation

// The nil coalescing operator (??) unwraps an optional if it contains a value,
// or returns a default value if the optional is nil.
// Syntax: optionalValue ?? defaultValue

// BASIC USAGE
var optionalName: String? = "Alice"
let name = optionalName ?? "Unknown"
print(name)  // "Alice"

optionalName = nil
let nameWhenNil = optionalName ?? "Unknown"
print(nameWhenNil)  // "Unknown"

// EQUIVALENT TO IF-LET WITH ELSE
// The nil coalescing operator is shorthand for:
let longForm = optionalName != nil ? optionalName! : "Unknown"
// But ?? is much more concise and safer!

// WITH USER INPUT
func greetUser(username: String?) {
    let displayName = username ?? "Guest"
    print("Hello, \(displayName)!")
}

greetUser(username: "Bob")    // "Hello, Bob!"
greetUser(username: nil)      // "Hello, Guest!"

// CHAINING NIL COALESCING OPERATORS
// You can chain multiple ?? to try several optionals
let primary: String? = nil
let secondary: String? = nil
let tertiary: String? = "Fallback"

let result = primary ?? secondary ?? tertiary ?? "Default"
print(result)  // "Fallback"

// PRACTICAL EXAMPLE: Configuration with defaults
struct AppConfig {
    var theme: String?
    var fontSize: Int?
    var notifications: Bool?
}

let userConfig = AppConfig(theme: nil, fontSize: 16, notifications: nil)

let theme = userConfig.theme ?? "Light"
let fontSize = userConfig.fontSize ?? 14
let notifications = userConfig.notifications ?? true

print("Theme: \(theme)")                    // "Light" (default)
print("Font Size: \(fontSize)")             // 16 (user's choice)
print("Notifications: \(notifications)")    // true (default)

// WITH DICTIONARIES
let scores = ["Math": 95, "English": 88]

let mathScore = scores["Math"] ?? 0
print("Math: \(mathScore)")  // 95

let scienceScore = scores["Science"] ?? 0
print("Science: \(scienceScore)")  // 0 (default)

// WITH ARRAYS
let items: [String]? = ["Apple", "Banana"]
let firstItem = items?.first ?? "No items"
print(firstItem)  // "Apple"

let emptyItems: [String]? = []
let firstInEmpty = emptyItems?.first ?? "No items"
print(firstInEmpty)  // "No items"

// COMBINING WITH OPTIONAL CHAINING
class Person {
    var name: String
    var address: Address?

    init(name: String) {
        self.name = name
    }
}

class Address {
    var city: String

    init(city: String) {
        self.city = city
    }
}

let person1 = Person(name: "John")
let city1 = person1.address?.city ?? "Unknown City"
print("\(person1.name) lives in \(city1)")

let person2 = Person(name: "Jane")
person2.address = Address(city: "San Francisco")
let city2 = person2.address?.city ?? "Unknown City"
print("\(person2.name) lives in \(city2)")

// WITH TYPE CASTING
let anyValue: Any = "Hello"
let stringValue = anyValue as? String ?? "Not a string"
print(stringValue)  // "Hello"

let numberValue: Any = 42
let stringFromNumber = numberValue as? String ?? "Not a string"
print(stringFromNumber)  // "Not a string"

// PROVIDING COMPUTED DEFAULTS
// The right side is only evaluated if the left side is nil
func expensiveDefault() -> String {
    print("Computing expensive default...")
    return "Default Value"
}

var value: String? = "Exists"
let result1 = value ?? expensiveDefault()
// "Computing expensive default..." is NOT printed

value = nil
let result2 = value ?? expensiveDefault()
// "Computing expensive default..." IS printed

// PRACTICAL EXAMPLE: API response handling
struct APIResponse {
    var message: String?
    var errorCode: Int?
}

func handleResponse(_ response: APIResponse) {
    let message = response.message ?? "No message provided"
    let errorCode = response.errorCode ?? 0

    if errorCode == 0 {
        print("Success: \(message)")
    } else {
        print("Error \(errorCode): \(message)")
    }
}

handleResponse(APIResponse(message: "Data fetched", errorCode: nil))
handleResponse(APIResponse(message: nil, errorCode: 404))

// COMMON PATTERN: Empty string for nil
func displayText(_ text: String?) -> String {
    return text ?? ""  // Return empty string instead of nil
}

print("'\(displayText("Hello"))'")    // 'Hello'
print("'\(displayText(nil))'")        // ''
