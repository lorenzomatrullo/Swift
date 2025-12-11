import Foundation

// Strong, weak, and unowned control how ARC manages memory.
// Critical for preventing memory leaks (retain cycles).

// RETAIN CYCLE PROBLEM
class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
        print("\(name) initialized")
    }

    deinit {
        print("\(name) deallocated")
    }
}

class Apartment {
    let unit: String
    var tenant: Person?  // Strong reference creates cycle

    init(unit: String) {
        self.unit = unit
    }

    deinit {
        print("Apartment \(unit) deallocated")
    }
}

var john: Person? = Person(name: "John")
var apt: Apartment? = Apartment(unit: "4A")
john?.apartment = apt
apt?.tenant = john
john = nil
apt = nil
print("Memory leaked - retain cycle!\n")

// WEAK REFERENCE (solution)
class ApartmentFixed {
    let unit: String
    weak var tenant: Person?  // Breaks the cycle

    init(unit: String) {
        self.unit = unit
    }

    deinit {
        print("Apartment \(unit) deallocated")
    }
}

// UNOWNED REFERENCE
class Customer {
    let name: String
    var card: CreditCard?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) deallocated")
    }
}

class CreditCard {
    let number: String
    unowned let customer: Customer  // Card can't exist without customer

    init(number: String, customer: Customer) {
        self.number = number
        self.customer = customer
    }

    deinit {
        print("Card deallocated")
    }
}

var bob: Customer? = Customer(name: "Bob")
bob?.card = CreditCard(number: "1234", customer: bob!)
bob = nil  // Both deallocated

// CLOSURE CAPTURE
class HTMLElement {
    let name: String

    lazy var asHTML: () -> String = { [weak self] in
        guard let self = self else { return "" }
        return "<\(self.name)>"
    }

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) deallocated")
    }
}

var element: HTMLElement? = HTMLElement(name: "div")
print(element?.asHTML() ?? "")
element = nil

// Use weak when reference can become nil
// Use unowned when reference will never be nil
