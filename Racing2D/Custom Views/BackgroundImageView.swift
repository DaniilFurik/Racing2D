//
//  BackgroundImageView.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

class BackgroundImageView: UIImageView {
    // MARK: - Constructor
    
    convenience init() {
        self.init(frame: .zero)
        
        image = UIImage(named: GlobalConstants.backgroundImage)
        contentMode = .scaleAspectFill
    }
}
