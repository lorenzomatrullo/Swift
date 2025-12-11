import Foundation

// Type aliases give alternative names to existing types.
// Makes code more readable and expressive.

// BASIC TYPE ALIAS
typealias Distance = Double

let marathon: Distance = 42.195
print("Marathon: \(marathon) km")

// TUPLE ALIAS
typealias Coordinate = (x: Double, y: Double)

let point: Coordinate = (x: 10, y: 20)
print("Point: (\(point.x), \(point.y))")

// CLOSURE ALIAS
typealias CompletionHandler = (Bool, String?) -> Void

func process(completion: CompletionHandler) {
    completion(true, "Done")
}

process { success, message in
    print("\nResult: \(message ?? "Unknown")")
}

// COMPLEX TYPE ALIASES
typealias JSONObject = [String: Any]
typealias StringDict = [String: String]

let user: JSONObject = [
    "id": 1,
    "name": "Alice"
]

let config: StringDict = [
    "theme": "dark",
    "lang": "en"
]

print("User: \(user)")
print("Config: \(config)")

// GENERIC TYPE ALIAS
typealias ResultHandler<T> = (Result<T, Error>) -> Void

func loadData(completion: ResultHandler<String>) {
    completion(.success("Data loaded"))
}

loadData { result in
    switch result {
    case .success(let data):
        print("\n\(data)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
