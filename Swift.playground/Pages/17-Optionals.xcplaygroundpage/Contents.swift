// An optional is a value that can either hold something or be empty (nil).
// You write Int? to mean "maybe an Int".

import Foundation

// Simple optional example.
var maybeNumber: Int? = 10        // this box currently holds 10
maybeNumber = nil                 // now the box is empty



// A book where the year might be unknown yet, so publicationYear is optional.
struct Book {
    let name: String
    let publicationYear: Int?
}

let firstHarryPotter = Book(
    name: "Harry Potter and the Sorcerer's Stone",
    publicationYear: 1997
)

let secondHarryPotter = Book(
    name: "Harry Potter and the Chamber of Secrets",
    publicationYear: 1998
)

let books = [firstHarryPotter, secondHarryPotter]

let unannouncedBook = Book(
    name: "Rebels and Lions",
    publicationYear: nil
)

// Optional binding with if let:
// "If this optional has a value, give it a name and run this code."
var book = Book(name: "", publicationYear: nil)

if let unwrappedPublicationYear = book.publicationYear {
    print("The book was published in \(unwrappedPublicationYear)")
} else {
    print("The book does not have an official publication date")
}



// Optional parameter in a function: middleName can be present or missing.
func printFullName(firstName: String, middleName: String?, lastName: String) {}

// Failable initializer that can return nil for invalid input.
struct Toddler {
    var birthName: String
    var monthsOld: Int
    
    init?(birthName: String, monthsOld: Int) {
        if monthsOld < 12 || monthsOld > 36 {
            return nil
        } else {
            self.birthName = birthName
            self.monthsOld = monthsOld
        }
    }
}

let possibleToddler = Toddler(birthName: "Joanna", monthsOld: 14)

if let toddler = possibleToddler {
    print("\(toddler.birthName) is \(toddler.monthsOld) months old")
} else {
    print("The age you specified for the toddler is not valid")
}




// Optional chaining through nested types.
struct Address {
    var buildingNumber: String?
    var streetName: String?
    var apartmentNumber: String?
}

struct Residence {
    var address: Address?
}

struct PersonOptional {
    var age: Int?
    var residence: Residence?
}

// Example of optional chaining in use.
let address = Address(buildingNumber: "10", streetName: "Main Street", apartmentNumber: nil)
let residence = Residence(address: address)
let person = PersonOptional(age: 30, residence: residence)

if let street = person.residence?.address?.streetName {
    print("Street name is \(street)")
}
