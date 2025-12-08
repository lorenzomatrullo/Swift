import Foundation

// Type aliases give an alternative name to an existing type.
// They make code more readable and expressive.
// Use typealias keyword to create them.

// BASIC TYPE ALIAS
typealias Distance = Double

let marathonDistance: Distance = 42.195
let sprintDistance: Distance = 100.0

print("Marathon: \(marathonDistance) km")
print("Sprint: \(sprintDistance) m")

// TYPE ALIAS FOR CLARITY
typealias Coordinate = (x: Double, y: Double)

let origin: Coordinate = (x: 0, y: 0)
let destination: Coordinate = (x: 10, y: 20)

func calculateDistance(from start: Coordinate, to end: Coordinate) -> Double {
    let dx = end.x - start.x
    let dy = end.y - start.y
    return sqrt(dx * dx + dy * dy)
}

print("\nDistance: \(calculateDistance(from: origin, to: destination))")

// TYPE ALIAS FOR COMPLEX TYPES
typealias StringDictionary = [String: String]
typealias IntArray = [Int]
typealias CompletionHandler = (Bool, String?) -> Void

let userInfo: StringDictionary = [
    "name": "Alice",
    "email": "alice@example.com"
]

let numbers: IntArray = [1, 2, 3, 4, 5]

func processData(completion: CompletionHandler) {
    // Simulate processing
    let success = true
    let message = success ? "Success" : "Failed"
    completion(success, message)
}

processData { success, message in
    print("\nProcess result: \(message ?? "Unknown")")
}

// TYPE ALIAS FOR NESTED TYPES
typealias JSONObject = [String: Any]
typealias JSONArray = [JSONObject]

let user: JSONObject = [
    "id": 1,
    "name": "Bob",
    "active": true
]

let users: JSONArray = [
    ["id": 1, "name": "Alice"],
    ["id": 2, "name": "Bob"]
]

print("\nFirst user: \(users[0])")

// TYPE ALIAS FOR CLOSURE TYPES
typealias FilterFunction = (Int) -> Bool
typealias TransformFunction = (Int) -> String
typealias ValidationResult = Result<String, Error>

func filterAndTransform(
    numbers: [Int],
    filter: FilterFunction,
    transform: TransformFunction
) -> [String] {
    return numbers.filter(filter).map(transform)
}

let result = filterAndTransform(
    numbers: [1, 2, 3, 4, 5, 6],
    filter: { $0 % 2 == 0 },
    transform: { "Number \($0)" }
)

print("\nTransformed: \(result)")

// TYPE ALIAS IN PROTOCOLS
typealias UserID = Int
typealias Username = String

protocol UserRepository {
    func findUser(byId id: UserID) -> Username?
    func allUsers() -> [UserID: Username]
}

struct InMemoryUserRepository: UserRepository {
    private var users: [UserID: Username] = [
        1: "alice",
        2: "bob",
        3: "charlie"
    ]

    func findUser(byId id: UserID) -> Username? {
        return users[id]
    }

    func allUsers() -> [UserID: Username] {
        return users
    }
}

let repo = InMemoryUserRepository()
if let username = repo.findUser(byId: 2) {
    print("\nUser 2: \(username)")
}

// TYPE ALIAS FOR GENERIC TYPES
typealias StringPair = (String, String)
typealias IntPair = (Int, Int)

let coordinates: StringPair = ("North", "South")
let dimensions: IntPair = (1920, 1080)

print("\nCoordinates: \(coordinates)")
print("Dimensions: \(dimensions)")

// TYPE ALIAS WITH GENERICS
typealias Handler<T> = (T) -> Void
typealias AsyncResult<T> = (Result<T, Error>) -> Void

func fetchData<T>(completion: AsyncResult<T>) {
    // Simulated async operation
}

// TYPE ALIAS FOR PROTOCOL COMPOSITION
typealias Codable = Decodable & Encodable  // Built-in Swift example
typealias NamedAndAged = Named & Aged

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Student: NamedAndAged {
    var name: String
    var age: Int
}

let student = Student(name: "Emma", age: 20)
print("\nStudent: \(student.name), age \(student.age)")

// PRACTICAL EXAMPLE: API Response Types
typealias HTTPHeaders = [String: String]
typealias QueryParameters = [String: String]
typealias APIResponse = Result<Data, Error>
typealias APICompletion = (APIResponse) -> Void

struct APIClient {
    func request(
        endpoint: String,
        headers: HTTPHeaders,
        parameters: QueryParameters,
        completion: APICompletion
    ) {
        print("\nRequesting: \(endpoint)")
        print("Headers: \(headers)")
        print("Parameters: \(parameters)")
    }
}

let client = APIClient()
client.request(
    endpoint: "/users",
    headers: ["Authorization": "Bearer token"],
    parameters: ["limit": "10", "page": "1"],
    completion: { result in
        print("Response received")
    }
)

// TYPE ALIAS FOR UNITS
typealias Seconds = Double
typealias Milliseconds = Int
typealias Meters = Double
typealias Kilograms = Double

struct Timer {
    var duration: Seconds

    func durationInMilliseconds() -> Milliseconds {
        return Milliseconds(duration * 1000)
    }
}

let timer = Timer(duration: 2.5)
print("\nTimer: \(timer.duration) seconds = \(timer.durationInMilliseconds()) ms")

// TYPE ALIAS FOR STATE MACHINE
enum ConnectionState {
    case disconnected
    case connecting
    case connected
    case error(String)
}

typealias ConnectionStateHandler = (ConnectionState) -> Void

func monitorConnection(stateChanged: ConnectionStateHandler) {
    stateChanged(.connecting)
    stateChanged(.connected)
}

print("\nMonitoring connection:")
monitorConnection { state in
    switch state {
    case .disconnected:
        print("Disconnected")
    case .connecting:
        print("Connecting...")
    case .connected:
        print("Connected!")
    case .error(let message):
        print("Error: \(message)")
    }
}

// WHEN TO USE TYPE ALIASES:
// 1. Make complex types more readable
// 2. Create semantic names (Distance, UserID, Email)
// 3. Simplify closure type signatures
// 4. Make refactoring easier (change definition in one place)
// 5. Document intent through naming
