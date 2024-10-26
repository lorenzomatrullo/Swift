import Foundation

/*
 CLASSES:
    A class is a reference type that encapsulates properties and methods, supports inheritance, and allows for shared instances.
 
 CLASSES vs. STRUCTS:
    structs work as copy
    structs are way faster
    
    classes work as reference
    classes are helpful when you wanna work with frameworks/inheritance
*/



class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func sayHello() {
        print("Hello there!")
    }
}

let person = Person(name: "Jasmine")
print(person.name)
person.sayHello()



