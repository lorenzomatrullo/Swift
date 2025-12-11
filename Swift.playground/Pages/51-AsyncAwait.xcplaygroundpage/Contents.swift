import Foundation

// Async/await makes asynchronous code look synchronous.
// Introduced in Swift 5.5 to replace completion handlers.

// BASIC ASYNC FUNCTION
func fetchData() async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "Data fetched"
}

// CALLING ASYNC FUNCTIONS (use Task in playgrounds)
Task {
    print("Fetching...")
    let data = await fetchData()
    print(data)
}

// ASYNC THROWS
enum NetworkError: Error {
    case invalidURL
}

func loadUser(id: Int) async throws -> String {
    guard id > 0 else {
        throw NetworkError.invalidURL
    }
    try await Task.sleep(nanoseconds: 500_000_000)
    return "User \(id)"
}

Task {
    do {
        let user = try await loadUser(id: 1)
        print("\n\(user)")
    } catch {
        print("Error: \(error)")
    }
}

// ASYNC LET (parallel execution)
func fetchName() async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "Alice"
}

func fetchAge() async -> Int {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return 30
}

Task {
    print("\nFetching in parallel...")

    async let name = fetchName()
    async let age = fetchAge()

    let result = (await name, await age)
    print("Name: \(result.0), Age: \(result.1)")
}

// TASK GROUPS (dynamic parallelism)
Task {
    await withTaskGroup(of: String.self) { group in
        for i in 1...3 {
            group.addTask {
                try? await Task.sleep(nanoseconds: 500_000_000)
                return "Task \(i) done"
            }
        }

        for await result in group {
            print(result)
        }
    }
}

// Async/await makes async code linear and readable
