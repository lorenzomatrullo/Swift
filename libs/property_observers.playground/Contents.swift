import Foundation

/*
 willSet:
    - This observer runs just before the property value changes.
    - The newValue variable represents what the property will be set to.
    - In this case, it prints a message showing the new value that totalSteps is about to be set to.

 didSet:
    - This observer runs immediately after the property's value has changed.
    - The oldValue variable holds the previous value of the property.
    - It checks if the new value is greater than the old value. If it is, it calculates how many steps were added and prints that number.
*/


struct StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        
        didSet {
            print("Added \(totalSteps - oldValue) steps")
        }
    }
}
