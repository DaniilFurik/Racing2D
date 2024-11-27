//
//  Manager.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

final class Manager {
    static let shared = Manager()
    
    var settingModel: SettingModel
    
    private init() {
        settingModel = SettingModel.init(carImage: GlobalConstants.firstCarImage) // брать из user defaults
    }
}
