//
//  ViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit
import SnapKit

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for subview in view.subviews {
            if subview is NavigationButton {
                subview.dropShadow()
                subview.addGradient()
            }
        }
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
        
        bckgImage.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        recordsButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        startGameButton.snp.makeConstraints { make in
            make.centerX.equalTo(recordsButton)
            make.bottom.equalTo(recordsButton.snp.top).offset(-Constants.verticalSpacing)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.centerX.equalTo(recordsButton)
            make.top.equalTo(recordsButton.snp.bottom).offset(Constants.verticalSpacing)
        }
    }
}
