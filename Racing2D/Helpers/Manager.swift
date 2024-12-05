//
//  Manager.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

import Foundation

final class Manager {
    static let shared = Manager()
    
    var appSettings = AppSettingsModel()
    
    private init() {
        appSettings = getAppSettings()
    }
    
    func saveAppSettings() {
        let data = try? JSONEncoder().encode(appSettings)
        UserDefaults.standard.set(data, forKey: GlobalConstants.keyAppSettings)
    }
    
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
        
        return [GlobalConstants.firstBarrierImage, GlobalConstants.secondBarrierImage, GlobalConstants.thirdBarrierImage].randomElement()!
    }
    
    func saveRecord(_ score: Int) {
        if score > .zero {
            let record = RecordModel(username: appSettings.username, score: score, gameSpeed: appSettings.gameSpeed)
            
            var array = getRecords()
            array.append(record)
            
            let data = try? JSONEncoder().encode(array)
            UserDefaults.standard.set(data, forKey: GlobalConstants.keyRecords)
        }
    }
    
    func getSortedRecords() -> Dictionary<String, [RecordModel]> {
        let array = getRecords()
        
        return [
            GlobalConstants.fastGameSpeedName:
                [RecordModel](array.filter { $0.gameSpeed == .fast }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
            GlobalConstants.mediumGameSpeedName:
                [RecordModel](array.filter { $0.gameSpeed == .medium }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
            GlobalConstants.slowGameSpeedName:
                [RecordModel](array.filter { $0.gameSpeed == .slow }.sorted {$0.score > $1.score}.prefix(GlobalConstants.countOfRecords)),
        ]
    }
    
    private func getAppSettings() -> AppSettingsModel {
        guard let data = UserDefaults.standard.data(forKey: GlobalConstants.keyAppSettings) else { return self.appSettings }
        guard let settings = try? JSONDecoder().decode(AppSettingsModel.self, from: data) else { return self.appSettings }
        
        return settings
    }
    
    private func getRecords() -> [RecordModel] {
        guard let data = UserDefaults.standard.data(forKey: GlobalConstants.keyRecords) else { return [] }
        guard let list = try? JSONDecoder().decode([RecordModel].self, from: data) else { return [] }
        
        return list
    }
}
