//
//  GlobalConstants.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

extension String {
    static let keyRecords = "KeyRecords"
    static let keyAppSettings = "KeyAppSettings"
}

enum GameSpeed: Int, Codable {
    case slow = 0
    case medium = 1
    case fast = 2
}

final class GlobalConstants {
    static let countOfRecords = 3
    
    static let slowGameSpeed = 1.0
    static let mediumGameSpeed = 0.7
    static let fastGameSpeed = 0.4
    
    static let slowGameSpeedName = "Slow Speed"
    static let mediumGameSpeedName = "Middle Speed"
    static let fastGameSpeedName = "Fast Speed"
    
    static let randomBarrier = "RandomBarrier"
    static let unknownUser = "Unknown"
    
    static let firstCarImage = "FirstCar"
    static let secondCarImage = "SecondCar"
    static let thirdCarImage = "ThirdCar"
    static let fourthCarImage = "FourthCar"
    
    static let firstBarrierImage = "FirstBarrier"
    static let secondBarrierImage = "SecondBarrier"
    static let thirdBarrierImage = "ThirdBarrier"
    
    static let backgroundImage = "Background"
}
