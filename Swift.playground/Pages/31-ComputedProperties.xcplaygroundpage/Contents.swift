import Foundation

// Computed properties don't store a value directly.
// Instead, they provide a getter and an optional setter
// to retrieve and set other properties indirectly.

// BASIC COMPUTED PROPERTY WITH GETTER ONLY (read-only)
struct Circle {
    var radius: Double

    // Computed property
    var diameter: Double {
        return radius * 2
    }

    var circumference: Double {
        return 2 * Double.pi * radius
    }

    var area: Double {
        return Double.pi * radius * radius
    }
}

var circle = Circle(radius: 5.0)
print("Radius: \(circle.radius)")
print("Diameter: \(circle.diameter)")
print("Circumference: \(circle.circumference)")
print("Area: \(circle.area)")

// COMPUTED PROPERTY WITH GETTER AND SETTER
struct Rectangle {
    var width: Double
    var height: Double

    // Computed property with both getter and setter
    var area: Double {
        get {
            return width * height
        }
        set {
            // 'newValue' is automatically provided
            // Calculate new dimensions maintaining aspect ratio
            let aspectRatio = width / height
            height = sqrt(newValue / aspectRatio)
            width = height * aspectRatio
        }
    }
}

var rect = Rectangle(width: 10, height: 5)
print("Original - Width: \(rect.width), Height: \(rect.height), Area: \(rect.area)")

rect.area = 100  // Setting the area updates width and height
print("After setting area - Width: \(rect.width), Height: \(rect.height), Area: \(rect.area)")

// SHORTHAND GETTER (single expression)
struct Square {
    var side: Double

    var area: Double {
        side * side  // Implicit return for single expression
    }

    var perimeter: Double {
        4 * side
    }
}

let square = Square(side: 4)
print("Square area: \(square.area)")
print("Square perimeter: \(square.perimeter)")

// CUSTOM SETTER WITH CUSTOM PARAMETER NAME
struct Temperature {
    var celsius: Double

    var fahrenheit: Double {
        get {
            return celsius * 9/5 + 32
        }
        set(newFahrenheit) {  // Custom parameter name
            celsius = (newFahrenheit - 32) * 5/9
        }
    }

    var kelvin: Double {
        get {
            return celsius + 273.15
        }
        set {  // Using default 'newValue'
            celsius = newValue - 273.15
        }
    }
}

var temp = Temperature(celsius: 25)
print("Celsius: \(temp.celsius)")
print("Fahrenheit: \(temp.fahrenheit)")
print("Kelvin: \(temp.kelvin)")

temp.fahrenheit = 98.6
print("\nAfter setting Fahrenheit to 98.6:")
print("Celsius: \(temp.celsius)")

// COMPUTED PROPERTIES IN CLASSES
class Person {
    var firstName: String
    var lastName: String

    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        set {
            let names = newValue.split(separator: " ")
            if names.count >= 2 {
                firstName = String(names[0])
                lastName = String(names[1])
            }
        }
    }

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let person = Person(firstName: "John", lastName: "Doe")
print("Full name: \(person.fullName)")

person.fullName = "Jane Smith"
print("After update - First: \(person.firstName), Last: \(person.lastName)")

// PRACTICAL EXAMPLE: Shopping cart
struct CartItem {
    var name: String
    var price: Double
    var quantity: Int

    var total: Double {
        return price * Double(quantity)
    }
}

struct ShoppingCart {
    var items: [CartItem]

    var subtotal: Double {
        items.reduce(0) { $0 + $1.total }
    }

    var tax: Double {
        subtotal * 0.08  // 8% tax
    }

    var total: Double {
        subtotal + tax
    }

    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
}

var cart = ShoppingCart(items: [
    CartItem(name: "Book", price: 15.99, quantity: 2),
    CartItem(name: "Pen", price: 2.50, quantity: 5)
])

print("Items in cart: \(cart.itemCount)")
print("Subtotal: $\(String(format: "%.2f", cart.subtotal))")
print("Tax: $\(String(format: "%.2f", cart.tax))")
print("Total: $\(String(format: "%.2f", cart.total))")

// COMPUTED PROPERTIES WITH STORED PROPERTIES
struct User {
    var username: String
    private var passwordHash: String

    // Computed property that works with stored property
    var isValidUsername: Bool {
        username.count >= 3 && username.count <= 20
    }

    init(username: String, password: String) {
        self.username = username
        self.passwordHash = String(password.hashValue)
    }
}

let user = User(username: "alice", password: "secret")
print("Valid username: \(user.isValidUsername)")

// COMPUTED TYPE PROPERTIES (static)
struct MathConstants {
    static var pi: Double {
        return Double.pi
    }

    static var e: Double {
        return 2.718281828459045
    }
}

print("Pi: \(MathConstants.pi)")
print("E: \(MathConstants.e)")
