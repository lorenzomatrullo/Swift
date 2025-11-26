// Chapter 15: Structs
// A struct is a simple "blueprint" for a value type. When you copy a struct,
// you get a new, independent value with its own stored data.

import Foundation

// This struct says that every PersonStruct has a single piece of data: a name.
// The sayHello() method uses that data to print a message.
struct PersonStruct {
    var name: String      // stored property
    
    func sayHello() {     // method
        print("Hello \(name)")
    }
}

let person1 = PersonStruct(name: "Lorenzo")   // create one instance
person1.sayHello()



// You can use a struct as a "shape" for many different values.
struct Shirt {
    var size: String
    var color: String
}

let myShirt = Shirt(size: "XL", color: "black")
let yourShirt = Shirt(size: "L", color: "white")



// A struct can also have methods that describe what the value can do.
struct CarStruct {
    var make: String
    var year: Int
    var color: String
    
    func description() -> String {
        "A \(color) \(make) from \(year)"
    }
}

let modelX = CarStruct(make: "Tesla", year: 2020, color: "red")
print(modelX.description())
