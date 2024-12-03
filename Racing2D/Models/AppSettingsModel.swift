//
//  SettingModel.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

final class AppSettingsModel {
    let username: String
    let carImage: String
    let barrierImage: String
    let gameSpeed: GameSpeed
    
    init(username: String, carImage: String, barrierImage: String, gameSpeed: GameSpeed) {
        self.username = username
        self.carImage = carImage
        self.barrierImage = barrierImage
        self.gameSpeed = gameSpeed
    }
}
