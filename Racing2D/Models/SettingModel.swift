//
//  SettingModel.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

final class SettingModel {
    let username: String
    let carImage: String
    let gameSpeed: Int
    let barrierImage: String
    
    init(carImage: String) {
        self.username = "User"
        self.carImage = carImage
        self.barrierImage = "barrier"
        self.gameSpeed = 1
    }
}
