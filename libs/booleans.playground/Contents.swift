import Foundation

// Boolean Values
let speedLimit = 65
let currentSpeed = 72
let isSpeeding = currentSpeed < speedLimit


// Boolean Value (NOT)
var isSnowing = false

if !isSnowing {
    print("It is not snowing.")
}


// Boolean Value (AND)
let temperature = 100

if temperature >= 65 && temperature <= 75 {
    print("The temperature is just right.")
} else if temperature < 65 {
    print("It is too  cold!")
} else {
    print("It is too hot!")
}


// Boolean Value (OR)
var isPluggedIn = false
var hasBatteryPower = true

if isPluggedIn || hasBatteryPower {
    print("You can use your laptop.")
} else {
    print("😞")
}
