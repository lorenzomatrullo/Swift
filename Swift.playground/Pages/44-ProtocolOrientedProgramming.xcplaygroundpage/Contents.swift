import Foundation

// Protocol-Oriented Programming (POP) favors protocols
// and protocol extensions over class inheritance.

// PROTOCOL EXTENSIONS (add default implementations)
protocol Identifiable {
    var id: String { get }
}

extension Identifiable {
    func displayID() {
        print("ID: \(id)")
    }
}

struct User: Identifiable {
    let id: String
}

let user = User(id: "U123")
user.displayID()

// PROTOCOL COMPOSITION (combine with &)
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

func greet(_ person: Named & Aged) {
    print("\nHello \(person.name), age \(person.age)")
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

greet(Person(name: "Bob", age: 30))

// PROTOCOL-ORIENTED DESIGN
protocol Drawable {
    func draw()
}

protocol Transformable {
    mutating func move(x: Double, y: Double)
}

struct Circle: Drawable, Transformable {
    var x: Double
    var y: Double

    func draw() {
        print("\nDrawing circle at (\(x), \(y))")
    }

    mutating func move(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}

var circle = Circle(x: 0, y: 0)
circle.draw()
circle.move(x: 5, y: 10)
circle.draw()

// Benefits: Composition over inheritance, value types support
