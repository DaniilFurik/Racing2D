//
//  RecordModel.swift
//  Racing2D
//
//  Created by Даниил on 2.12.24.
//

final class RecordModel: Codable {
    let username: String
    let score: Int
    let gameSpeed: GameSpeed
    let avatar: String
    
    init(username: String, score: Int, gameSpeed: GameSpeed, avatar: String) {
        self.username = username
        self.score = score
        self.gameSpeed = gameSpeed
        self.avatar = avatar
    }
}
