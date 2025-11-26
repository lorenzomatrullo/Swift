// Chapter 7: Switch statements

import Foundation

// Basic switch
let numberOfWheels = 2

switch numberOfWheels {
case 0:
    print("Missing something")
case 1:
    print("Unicycle")
case 2:
    print("Bicycle")
case 3:
    print("Tricycle")
case 4:
    print("Quadcycle")
default:
    print("That's a lot of wheels!")
}

// Switch with ranges
var distance: Int = 11

switch distance {
case 0...9:
    print("Your destination is close.")
case 10...99:
    print("Your destination is a medium distance from here.")
case 100...999:
    print("Your destination is far from here.")
default:
    print("Are you sure you want to travel this far?")
}
