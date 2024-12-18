//
//  BackgroundImageView.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

class AvatarImageView: UIImageView {
    // MARK: - Constructor
    
    convenience init(size :CGFloat, interactionEnabled: Bool = false) {
        self.init(frame: .zero)
        
        layer.cornerRadius = size / 2
        clipsToBounds = true
        isUserInteractionEnabled = interactionEnabled
    }
}
