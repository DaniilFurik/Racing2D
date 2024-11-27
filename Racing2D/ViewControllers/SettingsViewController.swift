//
//  SettingsViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    
}

class SettingsViewController: UIViewController {
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

private extension SettingsViewController {
    // MARK: - Methods
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let bckgImage = BackgroundImageView()
        view.addSubview(bckgImage)
        
        NSLayoutConstraint.activate([
            bckgImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            bckgImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            bckgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bckgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
