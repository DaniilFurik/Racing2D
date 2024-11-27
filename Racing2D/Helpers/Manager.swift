//
//  Manager.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

final class Manager {
    static let shared = Manager()
    
    let settingModel: SettingModel
    
    private init() {
        // брать из user defaults
        settingModel = SettingModel.init(
            username: "",
            carImage: GlobalConstants.firstCarImage,
            barrierImage: GlobalConstants.firstBarrierImage,
            gameSpeed: 1
        )
    }
}
