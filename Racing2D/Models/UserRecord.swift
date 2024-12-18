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
    
    init(username: String, score: Int, gameSpeed: GameSpeed, avatarFileName: String) {
        self.username = username
        self.score = score
        self.gameSpeed = gameSpeed
        self.avatarFileName = avatarFileName
    }
}
