import Foundation

// Async/await is Swift's modern approach to asynchronous programming.
// Introduced in Swift 5.5, it makes async code look and behave like synchronous code.
// Much cleaner than completion handlers and callbacks.

// BASIC ASYNC FUNCTION
// Use 'async' keyword to mark a function as asynchronous
func fetchUserData() async -> String {
    // Simulate network delay
    try? await Task.sleep(nanoseconds: 1_000_000_000)  // 1 second
    return "User data fetched"
}

// CALLING ASYNC FUNCTIONS
// Use 'await' keyword when calling async functions
func demonstrateAsync() async {
    print("Starting fetch...")
    let data = await fetchUserData()
    print(data)
}

// Note: In playgrounds, you need to use Task to run async code
Task {
    await demonstrateAsync()
}

// ASYNC FUNCTIONS WITH ERRORS
enum NetworkError: Error {
    case invalidURL
    case serverError
    case timeout
}

func fetchData(from url: String) async throws -> Data {
    // Simulate potential errors
    guard url.starts(with: "https://") else {
        throw NetworkError.invalidURL
    }

    // Simulate network delay
    try await Task.sleep(nanoseconds: 500_000_000)  // 0.5 seconds

    // Simulate successful response
    return Data([1, 2, 3, 4, 5])
}

// CALLING THROWING ASYNC FUNCTIONS
Task {
    do {
        print("\nFetching data...")
        let data = try await fetchData(from: "https://api.example.com")
        print("Received \(data.count) bytes")
    } catch NetworkError.invalidURL {
        print("Invalid URL")
    } catch {
        print("Error: \(error)")
    }
}

// ASYNC LET - PARALLEL EXECUTION
// Run multiple async operations concurrently
func fetchUsername() async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "Alice"
}

func fetchUserEmail() async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "alice@example.com"
}

func fetchUserAge() async -> Int {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return 30
}

Task {
    print("\nFetching user info in parallel...")
    let startTime = Date()

    // These run concurrently!
    async let name = fetchUsername()
    async let email = fetchUserEmail()
    async let age = fetchUserAge()

    // Await all results
    let user = (await name, await email, await age)
    let duration = Date().timeIntervalSince(startTime)

    print("Name: \(user.0)")
    print("Email: \(user.1)")
    print("Age: \(user.2)")
    print("Completed in \(String(format: "%.1f", duration)) seconds")
}

// TASK GROUPS - DYNAMIC PARALLEL EXECUTION
func downloadFile(id: Int) async -> String {
    try? await Task.sleep(nanoseconds: 500_000_000)
    return "File \(id) downloaded"
}

Task {
    print("\nDownloading files with TaskGroup...")

    let results = await withTaskGroup(of: String.self) { group in
        for i in 1...5 {
            group.addTask {
                await downloadFile(id: i)
            }
        }

        var downloaded: [String] = []
        for await result in group {
            downloaded.append(result)
            print(result)
        }
        return downloaded
    }

    print("Total files: \(results.count)")
}

// ASYNC PROPERTIES
struct UserProfile {
    let id: Int

    var details: String {
        get async {
            try? await Task.sleep(nanoseconds: 500_000_000)
            return "User \(id) details"
        }
    }
}

Task {
    print("\nFetching async property...")
    let profile = UserProfile(id: 123)
    let details = await profile.details
    print(details)
}

// ASYNC SEQUENCES
// Process values as they arrive
func generateNumbers() -> AsyncStream<Int> {
    AsyncStream { continuation in
        Task {
            for i in 1...5 {
                try? await Task.sleep(nanoseconds: 500_000_000)
                continuation.yield(i)
            }
            continuation.finish()
        }
    }
}

Task {
    print("\nAsync sequence:")
    for await number in generateNumbers() {
        print("Received: \(number)")
    }
    print("Sequence complete")
}

// CONTINUATION - BRIDGING CALLBACK-BASED CODE
func fetchDataWithCompletion(completion: @escaping (Result<String, Error>) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
        completion(.success("Data from callback"))
    }
}

func fetchDataAsync() async throws -> String {
    return try await withCheckedThrowingContinuation { continuation in
        fetchDataWithCompletion { result in
            switch result {
            case .success(let data):
                continuation.resume(returning: data)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }
}

Task {
    print("\nBridging callback to async/await...")
    let data = try? await fetchDataAsync()
    print(data ?? "Failed")
}

// TASK CANCELLATION
func longRunningTask() async {
    for i in 1...10 {
        // Check if task was cancelled
        if Task.isCancelled {
            print("Task was cancelled at step \(i)")
            return
        }

        print("Step \(i)")
        try? await Task.sleep(nanoseconds: 200_000_000)
    }
    print("Task completed")
}

Task {
    print("\nStarting cancellable task...")
    let task = Task {
        await longRunningTask()
    }

    // Cancel after 0.5 seconds
    try? await Task.sleep(nanoseconds: 500_000_000)
    task.cancel()
}

// ACTOR - THREAD-SAFE STATE MANAGEMENT
actor Counter {
    private var value = 0

    func increment() {
        value += 1
    }

    func getValue() -> Int {
        return value
    }
}

Task {
    print("\nActor example (thread-safe):")
    let counter = Counter()

    // Run multiple concurrent increments
    await withTaskGroup(of: Void.self) { group in
        for _ in 1...100 {
            group.addTask {
                await counter.increment()
            }
        }
    }

    let finalValue = await counter.getValue()
    print("Final count: \(finalValue)")  // Always 100, thread-safe!
}

// PRACTICAL EXAMPLE: API CLIENT
struct APIClient {
    func fetchUser(id: Int) async throws -> User {
        try await Task.sleep(nanoseconds: 500_000_000)

        guard id > 0 else {
            throw NetworkError.invalidURL
        }

        return User(id: id, name: "User \(id)", email: "user\(id)@example.com")
    }

    func fetchPosts(userId: Int) async throws -> [Post] {
        try await Task.sleep(nanoseconds: 500_000_000)
        return [
            Post(id: 1, userId: userId, title: "First Post"),
            Post(id: 2, userId: userId, title: "Second Post")
        ]
    }
}

struct User {
    let id: Int
    let name: String
    let email: String
}

struct Post {
    let id: Int
    let userId: Int
    let title: String
}

Task {
    print("\nAPI Client example:")
    let client = APIClient()

    do {
        // Fetch user and posts sequentially
        let user = try await client.fetchUser(id: 1)
        print("User: \(user.name)")

        let posts = try await client.fetchPosts(userId: user.id)
        print("Posts: \(posts.count)")

        for post in posts {
            print("- \(post.title)")
        }
    } catch {
        print("Error: \(error)")
    }
}

// BENEFITS OF ASYNC/AWAIT:
// 1. Linear, readable code (no callback pyramids)
// 2. Natural error handling with try/catch
// 3. Easy to reason about execution flow
// 4. Built-in support for cancellation
// 5. Actors provide thread-safety
// 6. Better performance than GCD in many cases

// Wait for async tasks to complete (playground-specific)
Thread.sleep(forTimeInterval: 8)

print("\nAsync/await makes asynchronous code easier to read and write!")
