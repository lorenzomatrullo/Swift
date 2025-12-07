import Foundation

// Repeat-while loop runs the body at least once, then checks the condition.
var attempts = 0

repeat {
    print("Attempt number \(attempts)")
    attempts += 1
} while attempts < 3
