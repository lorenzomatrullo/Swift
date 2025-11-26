import Foundation

// Boolean values
let speedLimit = 65
let currentSpeed = 72
let isSpeeding = currentSpeed < speedLimit

// Logical NOT
var isSnowing = false

if !isSnowing {
    print("It is not snowing.")
}

// Logical AND
let temperature = 100

if temperature >= 65 && temperature <= 75 {
    print("The temperature is just right.")
} else if temperature < 65 {
    print("It is too  cold!")
} else {
    print("It is too hot!")
}

// Logical OR
var isPluggedIn = false
var hasBatteryPower = true

if isPluggedIn || hasBatteryPower {
    print("You can use your laptop.")
} else {
    print("😞")
}

// Summary of logical operators: ==, !=, >, >=, <, <=, &&, ||, !
