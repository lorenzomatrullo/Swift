import Foundation

// Subscripts provide bracket notation [] access to elements.
// Like arrays and dictionaries, you can define custom subscripts.

// BASIC SUBSCRIPT (read-only)
struct TimesTable {
    let multiplier: Int

    subscript(index: Int) -> Int {
        multiplier * index
    }
}

let table = TimesTable(multiplier: 3)
print("3 x 5 = \(table[5])")

// SUBSCRIPT WITH GETTER AND SETTER
struct Matrix {
    var grid: [[Int]]

    init(rows: Int, columns: Int) {
        grid = Array(repeating: Array(repeating: 0, count: columns), count: rows)
    }

    subscript(row: Int, col: Int) -> Int {
        get { grid[row][col] }
        set { grid[row][col] = newValue }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 0] = 1
matrix[1, 1] = 5
print("\nMatrix [0,0]: \(matrix[0, 0])")

// PRACTICAL EXAMPLE: Safe array access
struct SafeArray<T> {
    private var array: [T]

    init(_ array: [T]) {
        self.array = array
    }

    subscript(index: Int) -> T? {
        guard index >= 0 && index < array.count else {
            return nil
        }
        return array[index]
    }
}

let safe = SafeArray([10, 20, 30])
print("Safe [1]: \(safe[1] ?? -1)")
print("Safe [10]: \(safe[10] ?? -1)")  // Out of bounds, returns nil
