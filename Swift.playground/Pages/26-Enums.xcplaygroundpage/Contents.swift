import Foundation

// Enums group related values into a type-safe list of cases.
enum CompassPoint {
    case north
    case south
    case east
    case west
}

let direction = CompassPoint.west

switch direction {
case .north:
    print("Heading north")
case .south:
    print("Heading south")
case .east:
    print("Heading east")
case .west:
    print("Heading west")
}
