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
            username: GlobalConstants.unknownUser,
            carImage: GlobalConstants.firstCarImage,
            barrierImage: GlobalConstants.randomBarrier,
            gameSpeed: GlobalConstants.fastGameSpeed
        )
    }
    
    func getBarrierImage() -> String {
        if settingModel.barrierImage != GlobalConstants.randomBarrier {
            return settingModel.barrierImage
        }
        
        return [GlobalConstants.firstBarrierImage, GlobalConstants.secondBarrierImage, GlobalConstants.thirdBarrierImage].randomElement()!
    }
}
