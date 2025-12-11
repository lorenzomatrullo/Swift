import Foundation

// Access control restricts access to code from other files/modules.
// Five levels: open, public, internal, fileprivate, private

// ACCESS LEVELS (most to least accessible):
// open       - subclassable outside module
// public     - accessible everywhere
// internal   - same module only (default)
// fileprivate - same file only
// private    - same declaration only

// PRIVATE - only within type
struct BankAccount {
    private var balance: Double = 0.0

    mutating func deposit(_ amount: Double) {
        balance += amount
        print("Balance: $\(balance)")
    }

    func getBalance() -> Double {
        balance
    }
}

var account = BankAccount()
account.deposit(100)
print("Balance: $\(account.getBalance())")
// account.balance = 1000  // Error: private

// PRIVATE(SET) - read publicly, write privately
struct Person {
    private(set) var age: Int

    init(age: Int) {
        self.age = age
    }

    mutating func haveBirthday() {
        age += 1
    }
}

var person = Person(age: 25)
print("\nAge: \(person.age)")  // Can read
person.haveBirthday()
// person.age = 30  // Error: setter is private

// FILEPRIVATE - accessible in same file
fileprivate func helper() {
    print("\nFile-private helper")
}

struct Processor {
    fileprivate var data: [String] = []

    func process() {
        helper()  // OK in same file
    }
}

Processor().process()

// Use private by default, increase access as needed
