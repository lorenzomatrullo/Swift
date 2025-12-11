import Foundation

// Associated values attach custom data to enum cases.
// Each case can store different types of data.

// BASIC ENUM WITH ASSOCIATED VALUES
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

let code = Barcode.qrCode("ABC123")

switch code {
case let .upc(a, b, c, d):
    print("UPC: \(a)-\(b)-\(c)-\(d)")
case let .qrCode(data):
    print("QR Code: \(data)")
}

// PRACTICAL EXAMPLE: Network Response
enum NetworkResponse {
    case success(Data)
    case failure(Int)
    case loading
}

func handle(_ response: NetworkResponse) {
    switch response {
    case .success(let data):
        print("\nSuccess: \(data.count) bytes")
    case .failure(let code):
        print("Error: \(code)")
    case .loading:
        print("Loading...")
    }
}

handle(.success(Data([1, 2, 3])))
handle(.failure(404))

// RECURSIVE ENUMS (use 'indirect')
indirect enum Expression {
    case number(Int)
    case add(Expression, Expression)
}

func eval(_ expr: Expression) -> Int {
    switch expr {
    case .number(let val):
        return val
    case .add(let left, let right):
        return eval(left) + eval(right)
    }
}

let expr = Expression.add(.number(5), .number(3))
print("\nResult: \(eval(expr))")

// AUTH STATE EXAMPLE
struct User {
    let name: String
}

enum AuthState {
    case loggedOut
    case loggedIn(User, token: String)
}

let state = AuthState.loggedIn(User(name: "Alice"), token: "abc")

switch state {
case .loggedOut:
    print("Please log in")
case .loggedIn(let user, let token):
    print("Welcome \(user.name)! Token: \(token)")
}
