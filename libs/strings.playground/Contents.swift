/*
 Strings:
    multi-line,
    empty,
    concatenation,
    interpolation,
    equality & comparison,
    prefix & suffix
*/

import Foundation

// STRINGS (multi-line)
let joke = """
Q: Why did the chicken cross the road?
A: To get to the other side!
"""
print(joke)



// STRINGS (empty)
var myString = ""                  // Declaration + Initialization of an empty string

if myString.isEmpty {
    print("The string is empty")
}



// STRINGS (concatenation)
let string1 = "Hello"
let string2 = ", world!"
var concatenatedString = string1 + string2    // "Hello, world!"



// STRINGS (interpolation)
let myName = "Rick"
let myAge = 30
print("\(myName) is \(myAge) years old")



// STRINGS (equality and comparison)
let month = "January"
let otherMonth = "January"
let lowercaseMonth = "january"

if month == otherMonth {
    print("They are the same")
}

if month != lowercaseMonth {
    print("They are not the same.")
}



// STRINGS (ignoring case)
let fullName = "Johnny Appleseed"

if fullName.lowercased() == "joHnnY aPPleseeD".lowercased() {
    print("The two names are equal.")
}



// STRINGS (prefix & suffix)
let greeting = "Hello, world!"

print(greeting.hasPrefix("Hello"))
print(greeting.hasSuffix("world!"))
print(greeting.hasSuffix("World!"))
