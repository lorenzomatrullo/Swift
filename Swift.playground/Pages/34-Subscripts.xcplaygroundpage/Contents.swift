import Foundation

// Subscripts are shortcuts for accessing elements in a collection, list, or sequence.
// They allow you to use bracket notation [] to get/set values.
// Arrays and dictionaries use subscripts behind the scenes.

// BASIC SUBSCRIPT IN A STRUCT
struct TimesTable {
    let multiplier: Int

    // Read-only subscript
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("3 x 5 = \(threeTimesTable[5])")
print("3 x 8 = \(threeTimesTable[8])")

// SUBSCRIPT WITH GETTER AND SETTER
struct Matrix {
    var grid: [[Int]]
    let rows: Int
    let columns: Int

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: Array(repeating: 0, count: columns), count: rows)
    }

    subscript(row: Int, column: Int) -> Int {
        get {
            return grid[row][column]
        }
        set {
            grid[row][column] = newValue
        }
    }
}

var matrix = Matrix(rows: 3, columns: 3)
matrix[0, 0] = 1
matrix[1, 1] = 5
matrix[2, 2] = 9

print("\nMatrix:")
for row in 0..<matrix.rows {
    for col in 0..<matrix.columns {
        print(matrix[row, col], terminator: " ")
    }
    print()
}

// SUBSCRIPT WITH MULTIPLE PARAMETERS
struct GameBoard {
    var board: [[String]]

    init(size: Int) {
        board = Array(repeating: Array(repeating: ".", count: size), count: size)
    }

    subscript(x: Int, y: Int) -> String {
        get {
            return board[x][y]
        }
        set {
            board[x][y] = newValue
        }
    }
}

var ticTacToe = GameBoard(size: 3)
ticTacToe[0, 0] = "X"
ticTacToe[1, 1] = "O"
ticTacToe[2, 2] = "X"

print("\nTic-Tac-Toe Board:")
for row in 0..<3 {
    for col in 0..<3 {
        print(ticTacToe[row, col], terminator: " ")
    }
    print()
}

// SUBSCRIPT WITH RANGE
struct Sequence {
    var values: [Int]

    subscript(range: Range<Int>) -> [Int] {
        return Array(values[range])
    }
}

let sequence = Sequence(values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
print("\nValues 2-5: \(sequence[2..<6])")

// SUBSCRIPT WITH STRING PARAMETER
struct PhoneDirectory {
    var contacts: [String: String] = [:]

    subscript(name: String) -> String? {
        get {
            return contacts[name]
        }
        set {
            contacts[name] = newValue
        }
    }
}

var directory = PhoneDirectory()
directory["Alice"] = "555-1234"
directory["Bob"] = "555-5678"

print("\nAlice's number: \(directory["Alice"] ?? "Not found")")
print("Charlie's number: \(directory["Charlie"] ?? "Not found")")

// TYPE SUBSCRIPTS (static/class)
struct Planet {
    static var planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

    static subscript(index: Int) -> String {
        return planets[index]
    }
}

print("\nThird planet: \(Planet[2])")
print("Fifth planet: \(Planet[4])")

// SUBSCRIPT WITH DIFFERENT RETURN TYPES
enum Direction {
    case north, south, east, west
}

struct Compass {
    subscript(direction: Direction) -> String {
        switch direction {
        case .north:
            return "↑"
        case .south:
            return "↓"
        case .east:
            return "→"
        case .west:
            return "←"
        }
    }
}

let compass = Compass()
print("\nNorth: \(compass[.north])")
print("East: \(compass[.east])")

// PRACTICAL EXAMPLE: Safe array access
struct SafeArray<T> {
    private var array: [T]

    init(_ array: [T]) {
        self.array = array
    }

    // Returns optional to safely handle out-of-bounds access
    subscript(index: Int) -> T? {
        get {
            guard index >= 0 && index < array.count else {
                return nil
            }
            return array[index]
        }
        set {
            guard let newValue = newValue,
                  index >= 0 && index < array.count else {
                return
            }
            array[index] = newValue
        }
    }

    var count: Int {
        return array.count
    }
}

let safeNumbers = SafeArray([10, 20, 30, 40, 50])
print("\nSafe access [2]: \(safeNumbers[2] ?? -1)")
print("Safe access [10]: \(safeNumbers[10] ?? -1)")  // Returns nil safely

// SUBSCRIPT WITH NAMED PARAMETERS
struct Temperature {
    var readings: [String: Double] = [:]

    subscript(day day: String) -> Double? {
        get {
            return readings[day]
        }
        set {
            readings[day] = newValue
        }
    }
}

var temps = Temperature()
temps[day: "Monday"] = 72.5
temps[day: "Tuesday"] = 68.0

print("\nMonday temp: \(temps[day: "Monday"] ?? 0)°F")

// COMPLEX SUBSCRIPT: Chess board
struct ChessBoard {
    var pieces: [String: String] = [:]

    subscript(file: Character, rank: Int) -> String? {
        get {
            let square = "\(file)\(rank)"
            return pieces[square]
        }
        set {
            let square = "\(file)\(rank)"
            pieces[square] = newValue
        }
    }
}

var chess = ChessBoard()
chess["e", 2] = "♙"  // White pawn
chess["e", 4] = "♟"  // Black pawn
chess["e", 1] = "♔"  // White king

print("\nChess e2: \(chess["e", 2] ?? "empty")")
print("Chess e4: \(chess["e", 4] ?? "empty")")
print("Chess a1: \(chess["a", 1] ?? "empty")")

// READONLY SUBSCRIPT (shorthand)
struct Fibonacci {
    subscript(n: Int) -> Int {
        if n <= 1 {
            return n
        }
        var a = 0
        var b = 1
        for _ in 2...n {
            let temp = a + b
            a = b
            b = temp
        }
        return b
    }
}

let fib = Fibonacci()
print("\nFibonacci numbers:")
for i in 0..<10 {
    print(fib[i], terminator: " ")
}
print()
