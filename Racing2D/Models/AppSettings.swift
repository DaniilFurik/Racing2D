//
//  SettingModel.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

final class AppSettings: Codable {
    var username: String
    var carImage: String
    var barrierImage: String
    var avatarFileName: String
    var gameSpeed: GameSpeed
    var controlType: ControlType
    
    init() {
        username =  GlobalConstants.unknownUser
        carImage = GlobalConstants.firstCarImage
        barrierImage = GlobalConstants.randomBarrier
        gameSpeed = GameSpeed.slow
        avatarFileName = .empty
        controlType = .manual
    }
}
