import Foundation

// Computed properties calculate a value dynamically
// rather than storing it. They provide a getter
// and an optional setter.

// BASIC COMPUTED PROPERTY (read-only)
struct Circle {
    var radius: Double

    var area: Double {
        Double.pi * radius * radius
    }
}

let circle = Circle(radius: 5.0)
print("Area: \(circle.area)")

// COMPUTED PROPERTY WITH GETTER AND SETTER
struct Temperature {
    var celsius: Double

    var fahrenheit: Double {
        get {
            celsius * 9/5 + 32
        }
        set {
            celsius = (newValue - 32) * 5/9
        }
    }
}

var temp = Temperature(celsius: 25)
print("Fahrenheit: \(temp.fahrenheit)")
temp.fahrenheit = 98.6
print("Celsius: \(temp.celsius)")

// PRACTICAL EXAMPLE
struct CartItem {
    var price: Double
    var quantity: Int

    var total: Double {
        price * Double(quantity)
    }
}

let item = CartItem(price: 15.99, quantity: 2)
print("Total: $\(item.total)")
