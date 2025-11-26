import Foundation

// Property observers let you react every time a stored property changes.
// willSet runs just before the new value is stored.
// didSet runs right after the new value is stored.
struct StepCounter {
    var totalSteps: Int = 0 {
        // newValue is the value that is about to be stored.
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        
        // oldValue is the previous value that was stored.
        didSet {
            print("Added \(totalSteps - oldValue) steps")
        }
    }
}

// Example usage:
var steps = StepCounter()
steps.totalSteps = 10      // willSet and then didSet are called
steps.totalSteps = 25      // observers run again with the new and old values
