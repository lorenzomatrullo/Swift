import Foundation

// Guard statements are used for early exits from functions or loops.
// They improve code readability by handling invalid cases first,
// leaving the main logic at the top level (avoiding nested if-let pyramids).

// BASIC GUARD SYNTAX
// guard condition else {
//     // Must exit the current scope (return, break, continue, throw)
// }

func processAge(_ age: Int?) {
    guard let validAge = age else {
        print("Age is nil, cannot process")
        return
    }

    // validAge is available in the rest of the function
    print("Processing age: \(validAge)")
    print("You are \(validAge) years old")
}

processAge(25)
processAge(nil)

// GUARD vs IF-LET
// Without guard (nested pyramids - "pyramid of doom"):
func validateUserIfLet(name: String?, age: Int?, email: String?) {
    if let name = name {
        if let age = age {
            if let email = email {
                print("User: \(name), Age: \(age), Email: \(email)")
            } else {
                print("Email is missing")
            }
        } else {
            print("Age is missing")
        }
    } else {
        print("Name is missing")
    }
}

// With guard (flat and readable):
func validateUserGuard(name: String?, age: Int?, email: String?) {
    guard let name = name else {
        print("Name is missing")
        return
    }

    guard let age = age else {
        print("Age is missing")
        return
    }

    guard let email = email else {
        print("Email is missing")
        return
    }

    // All values are unwrapped and available here
    print("User: \(name), Age: \(age), Email: \(email)")
}

validateUserGuard(name: "Alice", age: 30, email: "alice@example.com")
validateUserGuard(name: "Bob", age: nil, email: "bob@example.com")

// MULTIPLE CONDITIONS IN ONE GUARD
func register(username: String?, password: String?, age: Int?) {
    guard let username = username,
          let password = password,
          let age = age,
          age >= 18 else {
        print("Registration failed: invalid or incomplete data")
        return
    }

    print("Registered user: \(username), Age: \(age)")
}

register(username: "user123", password: "pass", age: 20)
register(username: "younguser", password: "pass", age: 15)

// GUARD WITH BOOLEAN CONDITIONS
func divide(_ a: Double, by b: Double) -> Double? {
    guard b != 0 else {
        print("Error: Cannot divide by zero")
        return nil
    }

    return a / b
}

if let result = divide(10, by: 2) {
    print("Result: \(result)")
}

if let result = divide(10, by: 0) {
    print("Result: \(result)")
}

// GUARD IN LOOPS
let numbers = [1, 2, nil, 4, nil, 6]

for number in numbers {
    guard let num = number else {
        print("Skipping nil value")
        continue  // Use continue in loops
    }

    print("Number: \(num)")
}

// GUARD WITH ARRAY ACCESS
func getFirstElement<T>(from array: [T]) -> T? {
    guard !array.isEmpty else {
        print("Array is empty")
        return nil
    }

    return array.first
}

let items = ["Apple", "Banana", "Cherry"]
if let first = getFirstElement(from: items) {
    print("First item: \(first)")
}

// GUARD WITH TYPE CASTING
func processValue(_ value: Any) {
    guard let stringValue = value as? String else {
        print("Value is not a string")
        return
    }

    print("String value: \(stringValue)")
}

processValue("Hello")
processValue(42)

// PRACTICAL EXAMPLE: Form validation
struct RegistrationForm {
    var username: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    var agreedToTerms: Bool?
}

func submitRegistration(_ form: RegistrationForm) -> Bool {
    guard let username = form.username, !username.isEmpty else {
        print("Username is required")
        return false
    }

    guard let email = form.email, email.contains("@") else {
        print("Valid email is required")
        return false
    }

    guard let password = form.password, password.count >= 8 else {
        print("Password must be at least 8 characters")
        return false
    }

    guard let confirmPassword = form.confirmPassword,
          password == confirmPassword else {
        print("Passwords do not match")
        return false
    }

    guard let agreed = form.agreedToTerms, agreed == true else {
        print("You must agree to the terms")
        return false
    }

    print("Registration successful for \(username)!")
    return true
}

let validForm = RegistrationForm(
    username: "alice",
    email: "alice@example.com",
    password: "secure123",
    confirmPassword: "secure123",
    agreedToTerms: true
)

submitRegistration(validForm)

let invalidForm = RegistrationForm(
    username: "bob",
    email: "invalid-email",
    password: "short",
    confirmPassword: "short",
    agreedToTerms: nil
)

submitRegistration(invalidForm)

// GUARD vs DEFER
// Guard exits early, defer runs cleanup code before exiting
func processFile(filename: String?) {
    guard let file = filename else {
        print("No filename provided")
        return
    }

    defer {
        print("Cleanup: Closing file \(file)")
    }

    print("Processing file: \(file)")
    // File processing logic here
}

processFile(filename: "data.txt")
