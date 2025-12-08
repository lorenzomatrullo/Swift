import Foundation

// While loop driven by a numeric condition
var numberOfLives = 3

while numberOfLives > 0 {
    print("I still have \(numberOfLives) lives.")
}

// While loop controlled by a Boolean flag
var stillAlive = true

while stillAlive {
    print("I still have \(numberOfLives) lives.")
    
    numberOfLives -= 1
    
    if numberOfLives <= 0 {
        stillAlive = false
    }
}

// Using break to exit a loop early
for counter in -10...10 {
    print(counter)
    
    if counter == 0 {
        break
    }
}
