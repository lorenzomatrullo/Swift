import Foundation

struct Book {
    let name: String
    let publicationYear: Int?   // optional declaration (specifying the data type)
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

let unaccouncedBook = Book(
    name: "Rebels and Lions",
    publicationYear: nil    // meaning "still not defined"
)


// Force-unwrap
var book = Book(name: "", publicationYear: nil)

if let unwrappedPublicationYear = book.publicationYear {
    print("The book was published in \(unwrappedPublicationYear)")
} else {
    print("The book does not hae an official publication date")
}


// Optionals in functions
func printFullName(firstName: String, middleName: String?, lastName: String) {}


// Failable initializers
struct Toddler {
    var birthName: String
    var monthsOld: Int
    
    init?(birthName: String, monthsOld: Int){
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
    print("The age you specified for the toddler is ")
}


// Optional chaining
struct Address {
    var buildingNumber: String?
    var streetName: String?
    var apartmentNumber: String?
}

struct Residence{
    var address: Address?
}

struct Person {
    var age: Int?
    var residence: Residence?
}

