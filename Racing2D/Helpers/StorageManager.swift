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
            let record = RecordModel(username: Manager.shared.appSettings.username, score: score, gameSpeed: Manager.shared.appSettings.gameSpeed, avatar: Manager.shared.appSettings.avatarImage)
            
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
    
    func saveImage(image: UIImage) -> String? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
              let data = image.jpegData(compressionQuality: 1) else {
            return nil
        }
        
        let fileName = UUID().uuidString
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getImage(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: fileUrl.path)
    }
}
