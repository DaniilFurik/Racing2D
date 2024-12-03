//
//  Manager.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

import Foundation

final class Manager {
    static let shared = Manager()
    
    let appSettings: AppSettingsModel
    
    private init() {
        // брать из user defaults
        appSettings = AppSettingsModel.init(
            username: GlobalConstants.unknownUser,
            carImage: GlobalConstants.firstCarImage,
            barrierImage: GlobalConstants.randomBarrier,
            gameSpeed: GameSpeed.slow
        )
    }
    
    func getBarrierImage() -> String {
        if appSettings.barrierImage != GlobalConstants.randomBarrier {
            return appSettings.barrierImage
        }
        
        return [GlobalConstants.firstBarrierImage, GlobalConstants.secondBarrierImage, GlobalConstants.thirdBarrierImage].randomElement()!
    }
    
    func saveRecord(_ score: Int) {
        let record = RecordModel(username: appSettings.username, score: score, gameSpeed: appSettings.gameSpeed)
        
        var array = getRecords()
        array.append(record)
        
        let data = try? JSONEncoder().encode(array)
        UserDefaults.standard.set(data, forKey: GlobalConstants.keyRecords)
    }
    
    func getSortedRecords() -> Dictionary<String, [RecordModel]> {
        let array = getRecords()
        
        return [
            GlobalConstants.fastGameSpeedName:array.filter { $0.gameSpeed == .fast },
            GlobalConstants.mediumGameSpeedName:array.filter { $0.gameSpeed == .medium },
            GlobalConstants.slowGameSpeedName:array.filter { $0.gameSpeed == .slow },
        ]
    }
    
    private func getRecords() -> [RecordModel] {
        guard let data = UserDefaults.standard.data(forKey: GlobalConstants.keyRecords) else { return [] }
        guard let list = try? JSONDecoder().decode([RecordModel].self, from: data) else { return [] }
        
        return list
    }
}
