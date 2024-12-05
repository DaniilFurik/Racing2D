//
//  SettingsViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let topSpacing: CGFloat = 64
    static let verticalSpacing: CGFloat = 8
    static let horizontalSpacing: CGFloat = 16
    static let imageSize: CGFloat = 80
    
    static let settingsTitle = "Settings"
    
    static let usernameText = "Username:"
    static let usernamePlaceholder = "Enter username"
    static let carImageText = "Select car:"
    static let barrierImageText = "Select barrier:"
    static let gameSpeedText = "Game speed:"
}

class SettingsViewController: UIViewController {
    // MARK: - Properties
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.usernamePlaceholder
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [GlobalConstants.slowGameSpeedName, GlobalConstants.mediumGameSpeedName, GlobalConstants.fastGameSpeedName])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        configureUI()
    }
}

private extension SettingsViewController {
    // MARK: - Methods
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = Constants.settingsTitle
        
        let bckgImage = BackgroundImageView()
        view.addSubview(bckgImage)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        containerView.roundCorners()
        view.addSubview(containerView)
        
        let userInfoView = UIView()
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(userInfoView)
        
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = Constants.usernameText
        userInfoView.addSubview(usernameLabel)
        
        usernameTextField.text = Manager.shared.appSettings.username
        usernameTextField.addAction(UIAction(handler: { _ in
            Manager.shared.appSettings.username = self.usernameTextField.text ?? GlobalConstants.unknownUser
            Manager.shared.saveAppSettings()
        }), for: .editingDidEnd)
        userInfoView.addSubview(usernameTextField)
        
        let carView = UIView()
        carView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(carView)
        
        let carImageLabel = UILabel()
        carImageLabel.translatesAutoresizingMaskIntoConstraints = false
        carImageLabel.text = Constants.carImageText
        carView.addSubview(carImageLabel)
        
        let carsView = UIView()
        carsView.translatesAutoresizingMaskIntoConstraints = false
        carView.addSubview(carsView)
        
        let firstCarImage = UIImageView()
        firstCarImage.translatesAutoresizingMaskIntoConstraints = false
        firstCarImage.image = UIImage(named: GlobalConstants.firstCarImage)
        carsView.addSubview(firstCarImage)
        
        let secondCarImage = UIImageView()
        secondCarImage.translatesAutoresizingMaskIntoConstraints = false
        secondCarImage.image = UIImage(named: GlobalConstants.secondCarImage)
        carsView.addSubview(secondCarImage)
        
        let thirdCarImage = UIImageView()
        thirdCarImage.translatesAutoresizingMaskIntoConstraints = false
        thirdCarImage.image = UIImage(named: GlobalConstants.thirdCarImage)
        carsView.addSubview(thirdCarImage)
        
        let barrierView = UIView()
        barrierView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(barrierView)
        
        let barrierImageLabel = UILabel()
        barrierImageLabel.translatesAutoresizingMaskIntoConstraints = false
        barrierImageLabel.text = Constants.barrierImageText
        barrierView.addSubview(barrierImageLabel)
        
        let barriersView = UIView()
        barriersView.translatesAutoresizingMaskIntoConstraints = false
        barrierView.addSubview(barriersView)
        
        let firstBarrierImage = UIImageView()
        firstBarrierImage.translatesAutoresizingMaskIntoConstraints = false
        firstBarrierImage.image = UIImage(named: GlobalConstants.firstBarrierImage)
        barriersView.addSubview(firstBarrierImage)
        
        let secondBarrierImage = UIImageView()
        secondBarrierImage.translatesAutoresizingMaskIntoConstraints = false
        secondBarrierImage.image = UIImage(named: GlobalConstants.secondBarrierImage)
        barriersView.addSubview(secondBarrierImage)
        
        let thirdBarrierImage = UIImageView()
        thirdBarrierImage.translatesAutoresizingMaskIntoConstraints = false
        thirdBarrierImage.image = UIImage(named: GlobalConstants.thirdBarrierImage)
        barriersView.addSubview(thirdBarrierImage)
        
        let gameSpeedView = UIView()
        gameSpeedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(gameSpeedView)
        
        let gameSpeedLabel = UILabel()
        gameSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        gameSpeedLabel.text = Constants.gameSpeedText
        gameSpeedView.addSubview(gameSpeedLabel)
        
        segmentedControl.selectedSegmentIndex = Manager.shared.appSettings.gameSpeed.rawValue
        segmentedControl.addAction(UIAction(handler: { _ in
            Manager.shared.appSettings.gameSpeed = GameSpeed(rawValue: self.segmentedControl.selectedSegmentIndex) ??  Manager.shared.appSettings.gameSpeed
            Manager.shared.saveAppSettings()
        }), for: .valueChanged)
        gameSpeedView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            bckgImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            bckgImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            bckgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bckgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalSpacing),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.horizontalSpacing),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topSpacing),
            
            userInfoView.topAnchor.constraint(equalTo: containerView.topAnchor),
            userInfoView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            userInfoView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: Constants.verticalSpacing),
            usernameLabel.leftAnchor.constraint(equalTo: userInfoView.leftAnchor, constant: Constants.horizontalSpacing),
            usernameLabel.rightAnchor.constraint(equalTo: userInfoView.rightAnchor, constant: -Constants.horizontalSpacing),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: Constants.verticalSpacing),
            usernameTextField.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor),
            usernameTextField.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor),
            usernameTextField.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: -Constants.verticalSpacing),
            
            carView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            carView.leftAnchor.constraint(equalTo: userInfoView.leftAnchor),
            carView.rightAnchor.constraint(equalTo: userInfoView.rightAnchor),
            
            carImageLabel.topAnchor.constraint(equalTo: carView.topAnchor, constant: Constants.verticalSpacing),
            carImageLabel.leftAnchor.constraint(equalTo: carView.leftAnchor, constant: Constants.horizontalSpacing),
            carImageLabel.rightAnchor.constraint(equalTo: carView.rightAnchor, constant: -Constants.horizontalSpacing),
            
            carsView.topAnchor.constraint(equalTo: carImageLabel.bottomAnchor, constant: Constants.verticalSpacing),
            carsView.leftAnchor.constraint(equalTo: carView.leftAnchor),
            carsView.rightAnchor.constraint(equalTo: carView.rightAnchor),
            carsView.bottomAnchor.constraint(equalTo: carView.bottomAnchor, constant: -Constants.verticalSpacing),
            
            firstCarImage.topAnchor.constraint(equalTo: carsView.topAnchor),
            firstCarImage.leftAnchor.constraint(equalTo: carsView.leftAnchor, constant: Constants.horizontalSpacing),
            firstCarImage.bottomAnchor.constraint(equalTo: carsView.bottomAnchor),
            firstCarImage.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            firstCarImage.heightAnchor.constraint(equalTo: firstCarImage.widthAnchor),
            
            secondCarImage.topAnchor.constraint(equalTo: firstCarImage.topAnchor),
            secondCarImage.leftAnchor.constraint(equalTo: firstCarImage.rightAnchor, constant: Constants.horizontalSpacing),
            secondCarImage.bottomAnchor.constraint(equalTo: firstCarImage.bottomAnchor),
            secondCarImage.widthAnchor.constraint(equalTo: firstCarImage.widthAnchor),
            secondCarImage.heightAnchor.constraint(equalTo: firstCarImage.widthAnchor),
            
            thirdCarImage.topAnchor.constraint(equalTo: secondCarImage.topAnchor),
            thirdCarImage.leftAnchor.constraint(equalTo: secondCarImage.rightAnchor, constant: Constants.horizontalSpacing),
            thirdCarImage.bottomAnchor.constraint(equalTo: secondCarImage.bottomAnchor),
            thirdCarImage.widthAnchor.constraint(equalTo: secondCarImage.widthAnchor),
            thirdCarImage.heightAnchor.constraint(equalTo: secondCarImage.widthAnchor),
            
            barrierView.topAnchor.constraint(equalTo: carView.bottomAnchor),
            barrierView.leftAnchor.constraint(equalTo: carView.leftAnchor),
            barrierView.rightAnchor.constraint(equalTo: carView.rightAnchor),
            
            barrierImageLabel.topAnchor.constraint(equalTo: barrierView.topAnchor, constant: Constants.verticalSpacing),
            barrierImageLabel.leftAnchor.constraint(equalTo: barrierView.leftAnchor, constant: Constants.horizontalSpacing),
            barrierImageLabel.rightAnchor.constraint(equalTo: barrierView.rightAnchor, constant: -Constants.horizontalSpacing),
            
            barriersView.topAnchor.constraint(equalTo: barrierImageLabel.bottomAnchor, constant: Constants.verticalSpacing),
            barriersView.leftAnchor.constraint(equalTo: barrierView.leftAnchor),
            barriersView.rightAnchor.constraint(equalTo: barrierView.rightAnchor),
            barriersView.bottomAnchor.constraint(equalTo: barrierView.bottomAnchor, constant: -Constants.verticalSpacing),
            
            firstBarrierImage.topAnchor.constraint(equalTo: barriersView.topAnchor),
            firstBarrierImage.leftAnchor.constraint(equalTo: barriersView.leftAnchor, constant: Constants.horizontalSpacing),
            firstBarrierImage.bottomAnchor.constraint(equalTo: barriersView.bottomAnchor),
            firstBarrierImage.widthAnchor.constraint(equalToConstant: Constants.imageSize / 1.5),
            firstBarrierImage.heightAnchor.constraint(equalTo: firstBarrierImage.widthAnchor),
            
            secondBarrierImage.topAnchor.constraint(equalTo: firstBarrierImage.topAnchor),
            secondBarrierImage.leftAnchor.constraint(equalTo: firstBarrierImage.rightAnchor, constant: Constants.horizontalSpacing),
            secondBarrierImage.bottomAnchor.constraint(equalTo: firstBarrierImage.bottomAnchor),
            secondBarrierImage.widthAnchor.constraint(equalTo: firstBarrierImage.widthAnchor),
            secondBarrierImage.heightAnchor.constraint(equalTo: firstBarrierImage.widthAnchor),
            
            thirdBarrierImage.topAnchor.constraint(equalTo: secondBarrierImage.topAnchor),
            thirdBarrierImage.leftAnchor.constraint(equalTo: secondBarrierImage.rightAnchor, constant: Constants.horizontalSpacing),
            thirdBarrierImage.bottomAnchor.constraint(equalTo: secondBarrierImage.bottomAnchor),
            thirdBarrierImage.widthAnchor.constraint(equalTo: secondBarrierImage.widthAnchor),
            thirdBarrierImage.heightAnchor.constraint(equalTo: secondBarrierImage.widthAnchor),
            
            gameSpeedView.topAnchor.constraint(equalTo: barrierView.bottomAnchor),
            gameSpeedView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            gameSpeedView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            gameSpeedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.verticalSpacing),
            
            gameSpeedLabel.topAnchor.constraint(equalTo: gameSpeedView.topAnchor, constant: Constants.verticalSpacing),
            gameSpeedLabel.leftAnchor.constraint(equalTo: gameSpeedView.leftAnchor, constant: Constants.horizontalSpacing),
            gameSpeedLabel.rightAnchor.constraint(equalTo: gameSpeedView.rightAnchor, constant: -Constants.horizontalSpacing),
            
            segmentedControl.topAnchor.constraint(equalTo: gameSpeedLabel.bottomAnchor, constant: Constants.verticalSpacing),
            segmentedControl.leftAnchor.constraint(equalTo: gameSpeedLabel.leftAnchor),
            segmentedControl.rightAnchor.constraint(equalTo: gameSpeedLabel.rightAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: gameSpeedView.bottomAnchor, constant: -Constants.verticalSpacing),
        ])
    }
    
    @objc func didTap() {
        view.endEditing(true) // закрыть клавиатуру
    }
}
