//
//  SettingModel.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

final class SettingModel {
    let username: String
    let carImage: String
    let barrierImage: String
    let gameSpeed: Int
    
    init(username: String, carImage: String, barrierImage: String, gameSpeed: Int) {
        self.username = username
        self.carImage = carImage
        self.barrierImage = barrierImage
        self.gameSpeed = gameSpeed
    }
}
