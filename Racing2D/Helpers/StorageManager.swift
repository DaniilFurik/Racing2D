//
//  StorageManager.swift
//  Racing2D
//
//  Created by Даниил on 13.12.24.
//

import UIKit

final class StorageManager {
    // MARK: - Properties
    
    static let shared = StorageManager()
    
    private init() { }
}

extension StorageManager {
    // MARK: - Methods
    
    func saveAppSettings() {
        UserDefaults.standard.set(encodable: Manager.shared.appSettings, forKey: .keyAppSettings)
    }
    
    func saveRecord(_ score: Int) {
        if score > .zero {
            let record = RecordModel(username: Manager.shared.appSettings.username, score: score, gameSpeed: Manager.shared.appSettings.gameSpeed)
            
            var array = getRecords()
            array.append(record)
            
            UserDefaults.standard.set(encodable: array, forKey: .keyRecords)
        }
    }
    
    func getAppSettings() -> AppSettingsModel {
        guard let settings = UserDefaults.standard.get(AppSettingsModel.self, forKey: .keyAppSettings) else { return AppSettingsModel() }
        
        return settings
    }
    
    func getRecords() -> [RecordModel] {
        guard let list = UserDefaults.standard.get([RecordModel].self, forKey: .keyRecords) else { return [] }
        
        return list
    }
}
