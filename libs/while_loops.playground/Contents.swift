import Foundation

/*
 WHILE LOOPS:
    A while loop is a control structure that repeatedly executes a block of code as long as a specified condition is true.
*/


// working with values
var numberOfLives = 3

while numberOfLives > 0 {
    print("I still have \(numberOfLives) lives.")
}


// working with booleans
var stillAlive = true

while stillAlive {
    print("I still have \(numberOfLives) lives.")
    
    numberOfLives -= 1
    
    if numberOfLives <= 0 {
        stillAlive = false
    }
}


// break used to stop the loop
for counter in -10...10 {
    print(counter)
    
    if counter == 0 {
        break
    }
}
