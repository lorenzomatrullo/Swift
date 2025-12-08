import Foundation

// Strong, weak, and unowned references control how ARC manages memory.
// Understanding these is crucial to prevent memory leaks (retain cycles).

// STRONG REFERENCES (default)
// Strong references increase the reference count and keep the instance alive.

// RETAIN CYCLE PROBLEM
// When two objects strongly reference each other, neither can be deallocated.

class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
        print("\(name) is initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    var tenant: Person?  // Strong reference

    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is initialized")
    }

    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

print("--- RETAIN CYCLE PROBLEM ---")
var john: Person? = Person(name: "John")
var unit4A: Apartment? = Apartment(unit: "4A")

// Create retain cycle
john?.apartment = unit4A
unit4A?.tenant = john

// Setting to nil doesn't deallocate - retain cycle!
john = nil
unit4A = nil
print("Variables set to nil, but objects still in memory!\n")

// WEAK REFERENCES
// Weak references don't increase the reference count.
// They automatically become nil when the instance is deallocated.
// Must be optional variables (var).

class ApartmentFixed {
    let unit: String
    weak var tenant: Person?  // Weak reference breaks the cycle

    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is initialized")
    }

    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

print("--- WEAK REFERENCE SOLUTION ---")
var alice: Person? = Person(name: "Alice")
var unit5B: ApartmentFixed? = ApartmentFixed(unit: "5B")

alice?.apartment = unit5B as? Apartment
unit5B?.tenant = alice

print("\nSetting references to nil:")
alice = nil  // Alice is deallocated
print("Tenant is now nil: \(unit5B?.tenant == nil)")
unit5B = nil  // Apartment is deallocated
print()

// PRACTICAL EXAMPLE: Delegate Pattern
protocol ViewControllerDelegate: AnyObject {
    func didUpdateData()
}

class ViewController {
    weak var delegate: ViewControllerDelegate?  // Weak to avoid retain cycle

    func updateData() {
        print("Data updated")
        delegate?.didUpdateData()
    }

    deinit {
        print("ViewController deinitialized")
    }
}

class DataManager: ViewControllerDelegate {
    var viewController: ViewController?

    init() {
        viewController = ViewController()
        viewController?.delegate = self  // Weak reference prevents cycle
    }

    func didUpdateData() {
        print("DataManager received update notification")
    }

    deinit {
        print("DataManager deinitialized")
    }
}

print("--- DELEGATE PATTERN ---")
var manager: DataManager? = DataManager()
manager?.viewController?.updateData()
manager = nil  // Both objects properly deallocated
print()

// UNOWNED REFERENCES
// Unowned references don't increase reference count like weak.
// BUT: They assume the instance always exists - crash if accessed after deallocation.
// Use when you're certain the reference will never be nil during its lifetime.
// Can be non-optional.

class Customer {
    let name: String
    var card: CreditCard?

    init(name: String) {
        self.name = name
        print("\(name) is initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: String
    unowned let customer: Customer  // Unowned - card can't exist without customer

    init(number: String, customer: Customer) {
        self.number = number
        self.customer = customer
        print("Card \(number) is initialized for \(customer.name)")
    }

    deinit {
        print("Card \(number) is being deinitialized")
    }
}

print("--- UNOWNED REFERENCE ---")
var bob: Customer? = Customer(name: "Bob")
bob?.card = CreditCard(number: "1234-5678", customer: bob!)

print("\nBob has card: \(bob?.card?.number ?? "none")")
print("Card belongs to: \(bob?.card?.customer.name ?? "none")")

bob = nil  // Both customer and card are deallocated
print()

// WEAK vs UNOWNED COMPARISON
// Use weak when:
// - The reference can become nil during its lifetime
// - The other instance can be deallocated first
// - You need optional behavior

// Use unowned when:
// - The reference will never be nil during its lifetime
// - The other instance has the same or longer lifetime
// - You want non-optional behavior

// CLOSURE CAPTURE LISTS
// Closures capture references strongly by default, which can create retain cycles.

class HTMLElement {
    let name: String
    let text: String?

    // Lazy closure that captures self strongly - RETAIN CYCLE!
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("HTMLElement '\(name)' initialized")
    }

    deinit {
        print("HTMLElement '\(name)' deinitialized")
    }
}

print("--- CLOSURE RETAIN CYCLE ---")
var heading: HTMLElement? = HTMLElement(name: "h1", text: "Hello")
print(heading?.asHTML() ?? "")
heading = nil  // NOT deallocated due to closure retain cycle!
print()

// FIXING CLOSURE RETAIN CYCLES with [weak self]
class HTMLElementFixed {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = { [weak self] in
        guard let self = self else { return "" }
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("HTMLElementFixed '\(name)' initialized")
    }

    deinit {
        print("HTMLElementFixed '\(name)' deinitialized")
    }
}

print("--- CLOSURE WITH [weak self] ---")
var paragraph: HTMLElementFixed? = HTMLElementFixed(name: "p", text: "World")
print(paragraph?.asHTML() ?? "")
paragraph = nil  // Properly deallocated!
print()

// CLOSURE WITH [unowned self]
class Counter {
    var count = 0

    lazy var increment: () -> Void = { [unowned self] in
        self.count += 1
        print("Count: \(self.count)")
    }

    init() {
        print("Counter initialized")
    }

    deinit {
        print("Counter deinitialized")
    }
}

print("--- CLOSURE WITH [unowned self] ---")
var counter: Counter? = Counter()
counter?.increment()
counter?.increment()
counter = nil  // Properly deallocated
print()

// MULTIPLE CAPTURES IN CLOSURE
class ViewController2 {
    var name: String

    init(name: String) {
        self.name = name
    }

    func setupClosure() {
        let handler = { [weak self] (message: String) in
            guard let self = self else { return }
            print("\(self.name): \(message)")
        }

        handler("Closure executed")
    }

    deinit {
        print("ViewController2 '\(name)' deinitialized")
    }
}

var vc: ViewController2? = ViewController2(name: "MainVC")
vc?.setupClosure()
vc = nil

// SUMMARY:
// - Strong: Default, increases reference count, keeps object alive
// - Weak: Optional, doesn't increase count, becomes nil when deallocated
// - Unowned: Non-optional, doesn't increase count, crashes if accessed after deallocation
// - Use [weak self] or [unowned self] in closures to prevent retain cycles
// - Prefer weak for delegates and closures
// - Use unowned when you're certain the reference outlives the closure

print("\nMemory management complete!")
