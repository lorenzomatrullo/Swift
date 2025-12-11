import Foundation

// ARC (Automatic Reference Counting) manages memory for classes.
// It tracks references and deallocates instances when count reaches zero.
// Only applies to classes, not structs or enums.

// BASIC ARC BEHAVIOR
class Person {
    let name: String

    init(name: String) {
        self.name = name
        print("\(name) initialized")
    }

    deinit {
        print("\(name) deallocated")
    }
}

var person1: Person? = Person(name: "Alice")  // ref count = 1
var person2: Person? = person1                // ref count = 2
var person3: Person? = person1                // ref count = 3

person1 = nil  // ref count = 2
person2 = nil  // ref count = 1
person3 = nil  // ref count = 0, instance deallocated

// SCOPE-BASED DEALLOCATION
class Book {
    let title: String

    init(title: String) {
        self.title = title
        print("Book '\(title)' created")
    }

    deinit {
        print("Book '\(title)' destroyed")
    }
}

func demonstrateScope() {
    let book = Book(title: "Swift")
    print("Inside function")
}  // book deallocated when function ends

print("\nCalling function:")
demonstrateScope()
print("Function ended")

// KEY POINTS:
// - ARC automatically manages memory
// - Only for classes (reference types)
// - Deallocates when reference count = 0
// - Use deinit for cleanup
