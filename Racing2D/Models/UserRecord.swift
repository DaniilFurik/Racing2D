//
//  RecordModel.swift
//  Racing2D
//
//  Created by Даниил on 2.12.24.
//

final class UserRecord: Codable {
    let username: String
    let score: Int
    let gameSpeed: GameSpeed
    let avatarFileName: String
    let date: Double
    
    init(username: String, score: Int, gameSpeed: GameSpeed, avatarFileName: String, date: Double) {
        self.username = username
        self.score = score
        self.gameSpeed = gameSpeed
        self.avatarFileName = avatarFileName
        self.date = date
    }
}
