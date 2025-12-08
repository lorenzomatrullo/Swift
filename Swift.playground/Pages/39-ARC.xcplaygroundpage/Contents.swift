import Foundation

// ARC (Automatic Reference Counting) manages memory for class instances.
// Swift automatically tracks and manages memory, freeing it when no longer needed.
// ARC only applies to classes (reference types), not structs or enums (value types).

// BASIC ARC BEHAVIOR
class Person {
    let name: String

    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

// Creating references
var person1: Person?
var person2: Person?
var person3: Person?

// Create instance - reference count = 1
person1 = Person(name: "Alice")

// Add more references - reference count = 3
person2 = person1
person3 = person1

print("\nThree references to Alice exist\n")

// Remove references one by one
person1 = nil  // reference count = 2
print("person1 set to nil\n")

person2 = nil  // reference count = 1
print("person2 set to nil\n")

person3 = nil  // reference count = 0 - instance deallocated
print("person3 set to nil\n")

// HOW ARC WORKS
// Every time you create a new reference to a class instance, ARC increments the reference count.
// Every time a reference is removed, ARC decrements the reference count.
// When the reference count reaches zero, ARC deallocates the instance.

class Book {
    let title: String

    init(title: String) {
        self.title = title
        print("Book '\(title)' is created")
    }

    deinit {
        print("Book '\(title)' is destroyed")
    }
}

func demonstrateScope() {
    let book = Book(title: "Swift Programming")
    print("Inside function scope")
    // book will be deallocated when function ends
}

print("\nCalling function:")
demonstrateScope()
print("Function ended\n")

// REFERENCE COUNTING WITH MULTIPLE OBJECTS
class Author {
    let name: String
    var books: [Book] = []

    init(name: String) {
        self.name = name
        print("Author '\(name)' created")
    }

    deinit {
        print("Author '\(name)' destroyed")
    }
}

var author: Author? = Author(name: "John Doe")
var book1: Book? = Book(title: "Book 1")
var book2: Book? = Book(title: "Book 2")

author?.books.append(book1!)
author?.books.append(book2!)

print("\nAuthor has \(author?.books.count ?? 0) books")

// Deallocating
book1 = nil
book2 = nil
print("\nBook references set to nil, but books still exist in author's array")

author = nil  // Author and their books are deallocated
print("\nAuthor set to nil\n")

// STRONG REFERENCES (default)
// By default, all references to class instances are strong.
// Strong references prevent the instance from being deallocated.

class Device {
    let name: String
    var owner: Person?

    init(name: String) {
        self.name = name
        print("Device '\(name)' created")
    }

    deinit {
        print("Device '\(name)' destroyed")
    }
}

var iPhone: Device? = Device(name: "iPhone")
var deviceOwner: Person? = Person(name: "Bob")

iPhone?.owner = deviceOwner

print("\niPhone owner: \(iPhone?.owner?.name ?? "None")")

// Both must be set to nil for deallocation
deviceOwner = nil
print("\ndeviceOwner set to nil, but Person still exists (referenced by iPhone)")

iPhone = nil
print("\niPhone set to nil, now Person is deallocated too\n")

// VALUE TYPES vs REFERENCE TYPES
// ARC doesn't apply to structs (value types)
struct Point {
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        print("Point created at (\(x), \(y))")
    }

    // Structs don't have deinit
}

func demonstrateValueType() {
    let point = Point(x: 10, y: 20)
    print("Using point")
    // Point is copied, not referenced
    // No ARC involved - memory managed differently
}

print("\nValue type example:")
demonstrateValueType()
print("Function ended - struct memory cleaned up automatically\n")

// PRACTICAL EXAMPLE: View Controller Pattern
class ViewController {
    var viewModel: ViewModel?

    init() {
        print("ViewController initialized")
        viewModel = ViewModel()
        print("Reference count for ViewModel: 1")
    }

    deinit {
        print("ViewController deinitialized")
    }
}

class ViewModel {
    var data: [String] = ["Item 1", "Item 2", "Item 3"]

    init() {
        print("ViewModel initialized")
    }

    deinit {
        print("ViewModel deinitialized")
    }
}

var viewController: ViewController? = ViewController()
print("\nViewController created with ViewModel")

viewController = nil
print("\nViewController deallocated, ViewModel automatically deallocated too\n")

// ARRAY OF CLASS INSTANCES
var people: [Person] = []

people.append(Person(name: "Alice"))
people.append(Person(name: "Bob"))
people.append(Person(name: "Charlie"))

print("\nArray has \(people.count) people")

// Removing from array decrements reference count
people.removeAll()
print("\nArray cleared - all people deallocated\n")

// KEY POINTS:
// 1. ARC is automatic - you don't manually allocate/deallocate
// 2. Only applies to classes (reference types)
// 3. Works by counting references to each instance
// 4. Deallocates when reference count reaches zero
// 5. Can create retain cycles (covered in next lesson)
// 6. Use deinit to perform cleanup before deallocation

print("ARC manages memory automatically for reference types!")
