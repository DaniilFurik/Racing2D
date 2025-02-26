//
//  GlobalConstants.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

extension String {
    static let empty = String()
    static let keyRecords = "KeyRecords"
    static let keyAppSettings = "KeyAppSettings"
}

enum TypeImage {
    case cars
    case barriers
}

enum GameSpeed: Int, Codable {
    case slow = 0
    case medium = 1
    case fast = 2
}

enum ControlType: Int, Codable {
    case manual = 0
    case accelerometer = 1
}

final class GlobalConstants {
    static let verticalSpacing: CGFloat = 8
    static let horizontalSpacing: CGFloat = 16
    
    static let countOfRecords = 3
    
    static let slowGameSpeed = 1.0
    static let mediumGameSpeed = 0.7
    static let fastGameSpeed = 0.4
    
    static let slowGameSpeedName = "Slow Speed"
    static let mediumGameSpeedName = "Middle Speed"
    static let fastGameSpeedName = "Fast Speed"
    
    static let manualTypeName = "Manual"
    static let accelerometerTypeName = "Accelerometer"
    
    static let randomBarrier = "RandomBarrier"
    static let unknownUser = "Unknown"
    
    static let firstCarImage = "FirstCar"
    static let secondCarImage = "SecondCar"
    static let thirdCarImage = "ThirdCar"
    static let fourthCarImage = "FourthCar"
    
    static let firstBarrierImage = "FirstBarrier"
    static let secondBarrierImage = "SecondBarrier"
    static let thirdBarrierImage = "ThirdBarrier"
    static let fourthBarrierImage = "FourthBarrier"
    static let randomBarrierImage = "RandomBarrier"
    
    static let barrierArray = [firstBarrierImage, secondBarrierImage, thirdBarrierImage, fourthBarrierImage]
    
    static let avatarImage = "Avatar"
    static let backgroundImage = "Background"
    
    static let dateFormat = "dd MMM yyyy HH'h' mm'm' ss's'"
}
