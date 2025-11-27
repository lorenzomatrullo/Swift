import Foundation

// Error handling lets you deal with problems using try and catch.
enum PasswordError: Error {
    case tooShort
}

func checkPassword(_ text: String) throws {
    if text.count < 8 {
        throw PasswordError.tooShort
    }
}

do {
    try checkPassword("short")
    print("Password is OK")
} catch {
    print("Password is not strong enough")
}
