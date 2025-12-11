import Foundation

// Optional chaining: safely go through "maybe-nil" properties/methods.
// If anything in the chain is nil, the whole expression becomes nil.

struct Address {
    var streetName: String
}

struct Person {
    var name: String
    var address: Address?   // this person might have no address
}

// Example 1: address is nil, so the chain returns nil.
let bob = Person(name: "Bob", address: nil)
let street1 = bob.address?.streetName
print(street1 as Any)      // prints nil

// Example 2: address exists, so we get the street name.
let address = Address(streetName: "Main Street")
let alice = Person(name: "Alice", address: address)
let street2 = alice.address?.streetName
print(street2 as Any)      // prints Optional("Main Street")


