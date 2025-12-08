import Foundation

// Generics let functions and types work with many kinds of values.
func repeatValue<T>(_ value: T, times: Int) -> [T] {
    var result: [T] = []
    
    for _ in 0..<times {
        result.append(value)
    }
    
    return result
}

let numbers = repeatValue(5, times: 3)
print(numbers)
