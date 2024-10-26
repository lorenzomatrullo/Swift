import Foundation

// override functions
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo!")
    }
}

let train = Train()
train.makeNoise()




// Optionals

// work better the init method
