/*
 STRUCTS: a structure that group releated variabless, under one name.
*/

import Foundation


struct Person {
    var name: String
    
    func sayHello() {
        print("Hello \(name)")
    }
}


let person1 = Person(name: "Lorenzo")
person1.sayHello()



// STRUCTS (instances)
struct Shirt {
    var size: String
    var color: String
}


let myShirt = Shirt(size: "XL", color: "black")
let yourShirt = Shirt(size: "L", color: "white")



// STRUCTS (functions inside)
struct Car {
    var make: String
    var year: Int
    var color: String
    
    func startEngine() {}
    
    func drive() {}
    
    func park() {}
    
    func steer() {}
}

let ModelX = Car(make: "Tesla", year: 2020, color: "red")
print("My car is a \(ModelX.make) made in \(ModelX.year) and colored \(ModelX.color)")
