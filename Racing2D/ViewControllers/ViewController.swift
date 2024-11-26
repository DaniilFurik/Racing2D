//
//  ViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let gameTitle = "Start Game"
    static let recordsTitle = "Records"
    static let settingsTitle = "Settings"
    
    static let verticalSpacing: CGFloat = 48
}

class ViewController: UIViewController {
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

private extension ViewController {
    // MARK: - Methods
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let bckgImage = BackgroundImageView()
        view.addSubview(bckgImage)
        
        let startGameButton = NavigationButton(title: Constants.gameTitle)
        startGameButton.addAction(UIAction(handler: { _ in
            self.navigationController?.pushViewController(GameViewController(), animated: true)
        }), for: .touchUpInside)
        view.addSubview(startGameButton)
        
        let recordsButton = NavigationButton(title: Constants.recordsTitle)
        recordsButton.addAction(UIAction(handler: { _ in
            self.navigationController?.pushViewController(RecordsViewController(), animated: true)
        }), for: .touchUpInside)
        view.addSubview(recordsButton)
        
        let settingsButton = NavigationButton(title: Constants.settingsTitle)
        settingsButton.addAction(UIAction(handler: { _ in
            self.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }), for: .touchUpInside)
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            recordsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            startGameButton.bottomAnchor.constraint(equalTo: recordsButton.topAnchor, constant: -Constants.verticalSpacing),
            startGameButton.centerXAnchor.constraint(equalTo: recordsButton.centerXAnchor),
            
            settingsButton.topAnchor.constraint(equalTo: recordsButton.bottomAnchor, constant: Constants.verticalSpacing),
            settingsButton.centerXAnchor.constraint(equalTo: recordsButton.centerXAnchor),
            
            bckgImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            bckgImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            bckgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bckgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
