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
    static let viewHeight: CGFloat = 125
    static let avatarSize: CGFloat = 75
    
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
        textField.placeholder = Constants.usernamePlaceholder
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [GlobalConstants.slowGameSpeedName, GlobalConstants.mediumGameSpeedName, GlobalConstants.fastGameSpeedName])
        return segmentedControl
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.avatarSize / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        initAvatar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            // контроллер удаляется из стека навигации
            StorageManager.shared.saveAppSettings()
        }
    }
}

private extension SettingsViewController {
    // MARK: - Methods
    
    func initAvatar() {
        avatarImage.image = Manager.shared.getAvatar(fileName: Manager.shared.appSettings.avatarFileName)
        avatarImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarImageTapped)))
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = Constants.settingsTitle
        
        let bckgImage = BackgroundImageView()
        view.addSubview(bckgImage)
        
        let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.roundCorners()
        view.addSubview(containerView)
        
        let userInfoView = UIView()
        containerView.addSubview(userInfoView)
        
        userInfoView.addSubview(avatarImage)
        
        let usernameLabel = UILabel()
        usernameLabel.text = Constants.usernameText
        userInfoView.addSubview(usernameLabel)
        
        usernameTextField.text = Manager.shared.appSettings.username
        usernameTextField.addAction(UIAction(handler: { _ in
            Manager.shared.appSettings.username = self.usernameTextField.text ?? GlobalConstants.unknownUser
        }), for: .allEditingEvents)
        userInfoView.addSubview(usernameTextField)
        
        let carView = UIView()
        containerView.addSubview(carView)
        
        let carImageLabel = UILabel()
        carImageLabel.text = Constants.carImageText
        carView.addSubview(carImageLabel)
        
        let carsView = ImageListView(images: [GlobalConstants.firstCarImage, GlobalConstants.secondCarImage, GlobalConstants.thirdCarImage, GlobalConstants.fourthCarImage], typeImage: TypeImage.cars)
        carView.addSubview(carsView)
        
        let barrierView = UIView()
        containerView.addSubview(barrierView)
        
        let barrierImageLabel = UILabel()
        barrierImageLabel.text = Constants.barrierImageText
        barrierView.addSubview(barrierImageLabel)
        
        var barrierArray = GlobalConstants.barrierArray
        barrierArray.insert(GlobalConstants.randomBarrierImage, at: .zero)
        
        let barriersView = ImageListView(images: barrierArray, typeImage: TypeImage.barriers)
        barrierView.addSubview(barriersView)
        
        let gameSpeedView = UIView()
        containerView.addSubview(gameSpeedView)
        
        let gameSpeedLabel = UILabel()
        gameSpeedLabel.text = Constants.gameSpeedText
        gameSpeedView.addSubview(gameSpeedLabel)
        
        segmentedControl.selectedSegmentIndex = Manager.shared.appSettings.gameSpeed.rawValue
        segmentedControl.addAction(UIAction(handler: { _ in
            Manager.shared.appSettings.gameSpeed = GameSpeed(rawValue: self.segmentedControl.selectedSegmentIndex) ??  Manager.shared.appSettings.gameSpeed
        }), for: .valueChanged)
        gameSpeedView.addSubview(segmentedControl)
        
        bckgImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.topSpacing)
        }
        
        userInfoView.snp.makeConstraints { make in
            make.top.left.right.equalTo(containerView)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(Constants.avatarSize)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.left.equalTo(avatarImage.snp.right).offset(GlobalConstants.horizontalSpacing)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
            make.bottom.equalTo(avatarImage.snp.bottom)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.left.right.equalTo(usernameTextField)
            make.bottom.equalTo(usernameTextField.snp.top).offset(-GlobalConstants.verticalSpacing)
        }
        
        carView.snp.makeConstraints { make in
            make.left.right.equalTo(userInfoView)
            make.top.equalTo(userInfoView.snp.bottom)
        }
        
        carImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
        }
        
        carsView.snp.makeConstraints { make in
            make.top.equalTo(carImageLabel.snp.bottom).offset(GlobalConstants.verticalSpacing)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
            make.height.equalTo(Constants.viewHeight)
        }
        
        barrierView.snp.makeConstraints { make in
            make.left.right.equalTo(carView)
            make.top.equalTo(carView.snp.bottom)
        }
        
        barrierImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
        }
        
        barriersView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(barrierImageLabel.snp.bottom).offset(GlobalConstants.verticalSpacing)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
            make.height.equalTo(Constants.viewHeight / 1.5)
        }
        
        gameSpeedView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(barrierView.snp.bottom)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
        
        gameSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.left.right.equalTo(gameSpeedLabel)
            make.top.equalTo(gameSpeedLabel.snp.bottom).offset(GlobalConstants.verticalSpacing)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
    }
    
    @objc func avatarImageTapped() {
        //Manager.shared.appSettings.avatarImage = StorageManager.shared.saveImage(image: UIImage(named: GlobalConstants.backgroundImage)!)!
    }
}
