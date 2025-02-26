//
//  NavigationButton.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let fontSize: CGFloat = 24
    static let cornerRadius: CGFloat = 16
    static let borderWidth: CGFloat = 1
    static let width: CGFloat = 200
    static let height: CGFloat = 48
}

class NavigationButton: UIButton {
    // MARK: - Constructor
    
    convenience init(title: String) {
        self.init(type: .system)
        
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        backgroundColor = .systemGreen
        titleLabel?.font = .systemFont(ofSize: Constants.fontSize)
        setTitle(title, for: .normal)
        
        snp.makeConstraints { make in
            make.width.equalTo(Constants.width)
            make.height.equalTo(Constants.height)
        }
    }
}
