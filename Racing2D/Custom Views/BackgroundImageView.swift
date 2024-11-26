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
        
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: "Background")
        contentMode = .scaleAspectFill
    }
}
