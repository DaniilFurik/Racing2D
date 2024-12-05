//
//  SettingModel.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

final class AppSettingsModel: Codable {
    var username: String
    var carImage: String
    var barrierImage: String
    var gameSpeed: GameSpeed
    
    init() {
        username =  GlobalConstants.unknownUser
        carImage = GlobalConstants.firstCarImage
        barrierImage = GlobalConstants.randomBarrier
        gameSpeed = GameSpeed.slow
    }
}
