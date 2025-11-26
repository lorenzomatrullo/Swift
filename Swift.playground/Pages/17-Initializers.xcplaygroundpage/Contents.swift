// init sets up a new instance, and self refers to this instance inside that function.

import Foundation

// A simple struct with a custom initializer.
struct User {
    var name: String
    var age: Int
    
    // This init runs every time you write User(name:age:).
    // self.name means "the name property of this User".
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let firstUser = User(name: "Lorenzo", age: 21)
print("User:", firstUser.name, "Age:", firstUser.age)

// Initializers can also provide default values.
struct Player {
    var nickname: String
    var score: Int
    
    // score has a default value if you do not pass one in.
    init(nickname: String, score: Int = 0) {
        self.nickname = nickname
        self.score = score
    }
}

let newPlayer = Player(nickname: "SwiftLearner")
print("\(newPlayer.nickname) starts with score \(newPlayer.score)")
