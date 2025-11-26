// Chapter 17: Classes

import Foundation

// Minimal Person class example
class PersonClass {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func sayHello() {
        print("Hello there!")
    }
}

let person = PersonClass(name: "Jasmine")
print(person.name)
person.sayHello()
