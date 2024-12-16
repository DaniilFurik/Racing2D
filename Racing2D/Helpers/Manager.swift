//
//  Manager.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

import Foundation

final class Manager {
    // MARK: - Properties
    
    static let shared = Manager()
    
    var appSettings = AppSettingsModel()
    
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
    
    func getSortedRecords() -> Dictionary<String, [RecordModel]> {
        let array = StorageManager.shared.getRecords()
        
        return [
            GlobalConstants.fastGameSpeedName:
                [RecordModel](array.filter { $0.gameSpeed == .fast }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
            GlobalConstants.mediumGameSpeedName:
                [RecordModel](array.filter { $0.gameSpeed == .medium }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
            GlobalConstants.slowGameSpeedName:
                [RecordModel](array.filter { $0.gameSpeed == .slow }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
        ]
    }
}
