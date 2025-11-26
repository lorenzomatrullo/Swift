// Chapter 2: Strings

import Foundation

// String basics: multiline literals, emptiness, concatenation, interpolation, comparison, prefix and suffix checks

// Multiline string literal
let joke = """
Q: Why did the chicken cross the road?
A: To get to the other side!
"""
print(joke)

// Empty string
var myString = ""

if myString.isEmpty {
    print("The string is empty")
}

// Concatenation
let string1 = "Hello"
let string2 = ", world!"
var concatenatedString = string1 + string2

// String interpolation
let myName = "Rick"
let myAge = 30
print("\(myName) is \(myAge) years old")

// Equality and comparison
let month = "January"
let otherMonth = "January"
let lowercaseMonth = "january"

if month == otherMonth {
    print("They are the same")
}

if month != lowercaseMonth {
    print("They are not the same.")
}

// Case-insensitive comparison
let fullName = "Johnny Appleseed"

if fullName.lowercased() == "joHnnY aPPleseeD".lowercased() {
    print("The two names are equal.")
}

// Prefix and suffix checks
let greeting = "Hello, world!"

print(greeting.hasPrefix("Hello"))
print(greeting.hasSuffix("world!"))
