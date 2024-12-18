//
//  Manager.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

import Foundation
import UIKit

final class Manager {
    // MARK: - Properties
    
    static let shared = Manager()
    
    var appSettings = AppSettings()
    
    private init() {
        appSettings = StorageManager.shared.getAppSettings()
    }
}

extension Manager {
    // MARK: - Methods
    
    func getMultGameSpeed() -> Double {
        switch appSettings.gameSpeed {
        case .fast:
            return GlobalConstants.fastGameSpeed
            
        case .medium:
            return GlobalConstants.mediumGameSpeed
            
        case .slow:
            return GlobalConstants.slowGameSpeed
        }
    }
    
    func getBarrierImage() -> String {
        if appSettings.barrierImage != GlobalConstants.randomBarrier {
            return appSettings.barrierImage
        }
        
        return GlobalConstants.barrierArray.randomElement()!
    }
    
    func getSortedRecords() -> Dictionary<String, [UserRecord]> {
        let array = StorageManager.shared.getRecords()
        
        return [
            GlobalConstants.fastGameSpeedName:
                [UserRecord](array.filter { $0.gameSpeed == .fast }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
            GlobalConstants.mediumGameSpeedName:
                [UserRecord](array.filter { $0.gameSpeed == .medium }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
            GlobalConstants.slowGameSpeedName:
                [UserRecord](array.filter { $0.gameSpeed == .slow }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
        ]
    }
    
    func getAvatar(fileName: String) -> UIImage {
        if fileName != .empty {
            if let image = StorageManager.shared.getImage(fileName: fileName) {
                return image
            }
        }
        
        return UIImage(named: GlobalConstants.avatarImage)!
    }
}
