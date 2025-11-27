import Foundation

// Extensions let you add functionality to an existing type.
extension String {
    func shout() -> String {
        uppercased() + "!"
    }
}

let message = "hello"
print(message.shout())
