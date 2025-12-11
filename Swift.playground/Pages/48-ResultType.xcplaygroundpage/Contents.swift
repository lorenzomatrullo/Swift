import Foundation

// Result is a built-in type for handling success and failure.
// It's an enum: .success(Value) or .failure(Error)

enum NetworkError: Error {
    case invalidURL
    case noData
}

// USING RESULT
func fetchData(from url: String) -> Result<Data, NetworkError> {
    guard !url.isEmpty else {
        return .failure(.invalidURL)
    }
    return .success(Data([1, 2, 3]))
}

let result = fetchData(from: "https://api.example.com")

switch result {
case .success(let data):
    print("Success: \(data.count) bytes")
case .failure(let error):
    print("Error: \(error)")
}

// RESULT WITH MAP
let mapped = result.map { data in
    "Received \(data.count) bytes"
}

// GET() METHOD (throws on failure)
do {
    let data = try result.get()
    print("Data: \(data)")
} catch {
    print("Error: \(error)")
}

// PRACTICAL: Completion handler with Result
func loadUser(id: Int, completion: (Result<String, Error>) -> Void) {
    completion(.success("User \(id)"))
}

loadUser(id: 1) { result in
    switch result {
    case .success(let user):
        print("\nLoaded: \(user)")
    case .failure(let error):
        print("Failed: \(error)")
    }
}
