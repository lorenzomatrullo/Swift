import Foundation

// Result is a built-in Swift type for handling success and failure.
// It's an enum with two cases: success(Value) and failure(Error)
// Much cleaner than using optional return values with separate error handling.

// BASIC RESULT TYPE
// Result<Success, Failure> where Failure conforms to Error

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case serverError(statusCode: Int)
}

// OLD WAY: Using optionals and throws
func fetchDataOldWay(from urlString: String) throws -> Data {
    guard let url = URL(string: urlString) else {
        throw NetworkError.invalidURL
    }
    // Simulated fetch
    return Data()
}

// NEW WAY: Using Result
func fetchData(from urlString: String) -> Result<Data, NetworkError> {
    guard let url = URL(string: urlString) else {
        return .failure(.invalidURL)
    }

    // Simulated successful fetch
    let data = Data([1, 2, 3, 4, 5])
    return .success(data)
}

// USING RESULT
let result = fetchData(from: "https://api.example.com")

switch result {
case .success(let data):
    print("Success! Received \(data.count) bytes")
case .failure(let error):
    print("Error: \(error)")
}

// RESULT WITH MAP
// Transform the success value while preserving failure
let stringResult = result.map { data in
    "Received \(data.count) bytes"
}

switch stringResult {
case .success(let message):
    print(message)
case .failure(let error):
    print("Error: \(error)")
}

// RESULT WITH FLATMAP
// Chain operations that can fail
func processData(_ data: Data) -> Result<String, NetworkError> {
    guard !data.isEmpty else {
        return .failure(.noData)
    }
    return .success("Processed \(data.count) bytes")
}

let processedResult = result.flatMap { data in
    processData(data)
}

print("\nProcessed result:")
switch processedResult {
case .success(let message):
    print(message)
case .failure(let error):
    print("Error: \(error)")
}

// RESULT WITH MAPTRUE
// Transform the error type
enum AppError: Error {
    case networkError(NetworkError)
    case unknown
}

let mappedError = result.mapError { networkError in
    AppError.networkError(networkError)
}

// GET() METHOD
// Throws the error if failure, returns value if success
do {
    let data = try result.get()
    print("\nGot data: \(data.count) bytes")
} catch {
    print("Error: \(error)")
}

// PRACTICAL EXAMPLE: User Authentication
struct User {
    let id: Int
    let username: String
    let email: String
}

enum AuthError: Error {
    case invalidCredentials
    case accountLocked
    case networkFailure
    case unknownError
}

func login(username: String, password: String) -> Result<User, AuthError> {
    // Simulate validation
    guard !username.isEmpty && !password.isEmpty else {
        return .failure(.invalidCredentials)
    }

    // Simulate successful login
    let user = User(id: 1, username: username, email: "\(username)@example.com")
    return .success(user)
}

let loginResult = login(username: "alice", password: "secret123")

switch loginResult {
case .success(let user):
    print("\nWelcome, \(user.username)!")
    print("Email: \(user.email)")
case .failure(let error):
    switch error {
    case .invalidCredentials:
        print("Invalid username or password")
    case .accountLocked:
        print("Your account has been locked")
    case .networkFailure:
        print("Network connection failed")
    case .unknownError:
        print("An unknown error occurred")
    }
}

// ASYNC COMPLETION HANDLERS WITH RESULT
typealias CompletionHandler<T> = (Result<T, Error>) -> Void

func fetchUser(id: Int, completion: CompletionHandler<User>) {
    // Simulate async operation
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
        let user = User(id: id, username: "user\(id)", email: "user\(id)@example.com")
        completion(.success(user))
    }
}

print("\nFetching user asynchronously...")
fetchUser(id: 42) { result in
    switch result {
    case .success(let user):
        print("Fetched user: \(user.username)")
    case .failure(let error):
        print("Failed to fetch user: \(error)")
    }
}

// CHAINING RESULTS
func validateUser(_ user: User) -> Result<User, ValidationError> {
    guard user.email.contains("@") else {
        return .failure(.invalidEmail)
    }
    return .success(user)
}

enum ValidationError: Error {
    case invalidEmail
    case invalidUsername
}

let validationResult = loginResult
    .flatMap { user in
        validateUser(user)
    }

print("\nValidation result:")
switch validationResult {
case .success(let user):
    print("Valid user: \(user.username)")
case .failure(let error):
    print("Validation failed: \(error)")
}

// RESULT BUILDERS
// Combine multiple results
func performOperations() -> Result<String, Error> {
    let step1 = fetchData(from: "https://api.example.com")
    let step2 = step1.flatMap { data in
        processData(data)
    }
    return step2.mapError { $0 as Error }
}

// CONVERTING THROWING FUNCTIONS TO RESULT
func throwingFunction() throws -> Int {
    return 42
}

let resultFromThrowing = Result { try throwingFunction() }

switch resultFromThrowing {
case .success(let value):
    print("\nValue: \(value)")
case .failure(let error):
    print("Error: \(error)")
}

// PRACTICAL API EXAMPLE
struct APIClient {
    enum APIError: Error {
        case invalidRequest
        case httpError(Int)
        case parsingError
    }

    func request<T>(_ endpoint: String, parser: (Data) -> T?) -> Result<T, APIError> {
        // Simulate request
        let data = Data([1, 2, 3])

        guard let parsed = parser(data) else {
            return .failure(.parsingError)
        }

        return .success(parsed)
    }
}

let client = APIClient()
let apiResult = client.request("/users") { data -> [String]? in
    return ["Alice", "Bob", "Charlie"]
}

print("\nAPI Result:")
switch apiResult {
case .success(let users):
    print("Users: \(users)")
case .failure(let error):
    print("API Error: \(error)")
}

// RESULT WITH CUSTOM ERROR TYPES
struct DetailedError: Error {
    let code: Int
    let message: String
    let timestamp: Date

    init(code: Int, message: String) {
        self.code = code
        self.message = message
        self.timestamp = Date()
    }
}

func performTask() -> Result<String, DetailedError> {
    let success = Bool.random()

    if success {
        return .success("Task completed successfully")
    } else {
        let error = DetailedError(code: 500, message: "Task failed")
        return .failure(error)
    }
}

let taskResult = performTask()
switch taskResult {
case .success(let message):
    print("\n✓ \(message)")
case .failure(let error):
    print("\n✗ Error \(error.code): \(error.message) at \(error.timestamp)")
}

// BENEFITS OF RESULT TYPE:
// 1. Explicit error handling - you must handle both success and failure
// 2. Better than optional return + error parameter pattern
// 3. Composable with map, flatMap, mapError
// 4. Type-safe - compiler ensures you handle both cases
// 5. Works great with async completion handlers
// 6. Can be converted to/from throwing functions

print("\nResult type provides clean, type-safe error handling!")
