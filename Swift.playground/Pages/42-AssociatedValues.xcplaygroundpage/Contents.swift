import Foundation

// Associated values allow you to attach custom data to enum cases.
// Each case can have different types and amounts of associated data.
// This makes enums incredibly powerful for modeling complex states.

// BASIC ENUM WITH ASSOCIATED VALUES
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productCode = Barcode.upc(8, 85909, 51226, 3)
print("Product code created")

productCode = Barcode.qrCode("ABCDEFGHIJKLMNOP")
print("Product code updated to QR code")

// EXTRACTING ASSOCIATED VALUES
switch productCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let code):
    print("QR Code: \(code)")
}

// SHORTHAND SYNTAX
switch productCode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem)-\(manufacturer)-\(product)-\(check)")
case let .qrCode(code):
    print("QR: \(code)")
}

// PRACTICAL EXAMPLE: Network Response
enum NetworkResponse {
    case success(data: Data)
    case failure(error: Error, statusCode: Int)
    case loading
}

struct CustomError: Error {
    let message: String
}

func handleResponse(_ response: NetworkResponse) {
    switch response {
    case .success(let data):
        print("Success! Received \(data.count) bytes")
    case .failure(let error, let statusCode):
        print("Error \(statusCode): \(error.localizedDescription)")
    case .loading:
        print("Loading...")
    }
}

let successResponse = NetworkResponse.success(data: Data([1, 2, 3, 4, 5]))
handleResponse(successResponse)

let failureResponse = NetworkResponse.failure(
    error: CustomError(message: "Connection lost"),
    statusCode: 500
)
handleResponse(failureResponse)

// MIXED ASSOCIATED VALUES
enum ServerResponse {
    case text(String)
    case json([String: Any])
    case xml(String)
    case binary(Data)
    case empty
}

let responses: [ServerResponse] = [
    .text("Hello World"),
    .json(["name": "Alice", "age": 30]),
    .xml("<root><item>Data</item></root>"),
    .binary(Data([0xFF, 0xD8, 0xFF])),
    .empty
]

for response in responses {
    switch response {
    case .text(let content):
        print("Text: \(content)")
    case .json(let dict):
        print("JSON: \(dict)")
    case .xml(let content):
        print("XML: \(content)")
    case .binary(let data):
        print("Binary: \(data.count) bytes")
    case .empty:
        print("Empty response")
    }
}

// ENUM WITH METHODS AND ASSOCIATED VALUES
enum Measurement {
    case distance(meters: Double)
    case time(seconds: Double)
    case temperature(celsius: Double)

    func description() -> String {
        switch self {
        case .distance(let meters):
            return "\(meters) meters"
        case .time(let seconds):
            return "\(seconds) seconds"
        case .temperature(let celsius):
            return "\(celsius)°C"
        }
    }

    func converted() -> String {
        switch self {
        case .distance(let meters):
            let feet = meters * 3.28084
            return "\(feet) feet"
        case .time(let seconds):
            let minutes = seconds / 60
            return "\(minutes) minutes"
        case .temperature(let celsius):
            let fahrenheit = celsius * 9/5 + 32
            return "\(fahrenheit)°F"
        }
    }
}

let distance = Measurement.distance(meters: 100)
print("\n\(distance.description()) = \(distance.converted())")

let temp = Measurement.temperature(celsius: 25)
print("\(temp.description()) = \(temp.converted())")

// RECURSIVE ENUMS
// Use 'indirect' to allow enums to reference themselves
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// (5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

print("\nResult: \(evaluate(product))")  // 18

// OPTIONAL PATTERN MATCHING
enum Result<T> {
    case success(T)
    case failure(Error)
}

let stringResult: Result<String> = .success("Hello")

if case .success(let value) = stringResult {
    print("\nSuccess with value: \(value)")
}

// PRACTICAL EXAMPLE: Authentication State
enum AuthState {
    case loggedOut
    case loggingIn(username: String)
    case loggedIn(user: User, token: String)
    case error(message: String)
}

struct User {
    let id: Int
    let username: String
}

func handleAuthState(_ state: AuthState) {
    switch state {
    case .loggedOut:
        print("Please log in")
    case .loggingIn(let username):
        print("Logging in as \(username)...")
    case .loggedIn(let user, let token):
        print("Welcome \(user.username)! Token: \(token)")
    case .error(let message):
        print("Auth error: \(message)")
    }
}

print()
handleAuthState(.loggedOut)
handleAuthState(.loggingIn(username: "alice"))
handleAuthState(.loggedIn(user: User(id: 1, username: "alice"), token: "abc123"))
handleAuthState(.error(message: "Invalid credentials"))

// PAYMENT METHOD EXAMPLE
enum PaymentMethod {
    case cash
    case creditCard(number: String, cvv: String)
    case debitCard(number: String, pin: String)
    case digitalWallet(provider: String, accountId: String)
}

func processPayment(_ method: PaymentMethod, amount: Double) {
    print("\nProcessing $\(amount) payment")

    switch method {
    case .cash:
        print("Payment method: Cash")
    case .creditCard(let number, _):
        let masked = String(number.suffix(4))
        print("Payment method: Credit Card ending in \(masked)")
    case .debitCard(let number, _):
        let masked = String(number.suffix(4))
        print("Payment method: Debit Card ending in \(masked)")
    case .digitalWallet(let provider, let accountId):
        print("Payment method: \(provider) wallet (\(accountId))")
    }
}

processPayment(.creditCard(number: "1234567890123456", cvv: "123"), amount: 99.99)
processPayment(.digitalWallet(provider: "Apple Pay", accountId: "user@example.com"), amount: 49.99)

// FILE SYSTEM EXAMPLE
indirect enum FileSystemItem {
    case file(name: String, size: Int)
    case folder(name: String, contents: [FileSystemItem])
}

func totalSize(of item: FileSystemItem) -> Int {
    switch item {
    case .file(_, let size):
        return size
    case .folder(_, let contents):
        return contents.reduce(0) { $0 + totalSize(of: $1) }
    }
}

let documents = FileSystemItem.folder(name: "Documents", contents: [
    .file(name: "report.pdf", size: 1024),
    .file(name: "image.jpg", size: 2048),
    .folder(name: "Backup", contents: [
        .file(name: "old_report.pdf", size: 512)
    ])
])

print("\nTotal size: \(totalSize(of: documents)) bytes")

// KEY TAKEAWAYS:
// - Associated values store custom data with each enum case
// - Each case can have different types and numbers of values
// - Use switch to extract and work with associated values
// - Great for modeling state machines and complex data
// - Use 'indirect' for recursive enum cases
