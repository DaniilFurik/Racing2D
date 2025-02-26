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
    static let menuTitle = "Select photo source"
    static let cameraTitle = "Camera"
    static let libraryTitle = "Photo Library"
    
    static let cameraImage = "camera"
    static let libraryImage = "photo"
    
    static let usernameText = "Username:"
    static let usernamePlaceholder = "Enter username"
    static let carImageText = "Select car:"
    static let barrierImageText = "Select barrier:"
    static let gameSpeedText = "Game speed:"
    static let controlTypeText = "Control type:"
}

class SettingsViewController: UIViewController {
    // MARK: - Properties
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.usernamePlaceholder
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let speedSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [GlobalConstants.slowGameSpeedName, GlobalConstants.mediumGameSpeedName, GlobalConstants.fastGameSpeedName])
        return segmentedControl
    }()
    
    private let controlTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [GlobalConstants.manualTypeName, GlobalConstants.accelerometerTypeName])
        return segmentedControl
    }()
    
    private let avatarImage = AvatarImageView(size: Constants.avatarSize, interactionEnabled: true)
    private lazy var avatarMenuButton: UIButton = {
        let menu = UIMenu(title: Constants.menuTitle, children: [
            UIAction(title: Constants.cameraTitle, image: UIImage(systemName: Constants.cameraImage)) { _ in
                self.showPhotoPicker(with: .camera, delegate: self)
            },
            UIAction(title: Constants.libraryTitle, image: UIImage(systemName: Constants.libraryImage)) { _ in
                self.showPhotoPicker(with: .photoLibrary, delegate: self)
            }
        ])
        
        let button = UIButton()
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        initAvatar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent || isBeingDismissed {
            // контроллер удаляется из стека навигации или закрывается модально
            StorageManager.shared.saveAppSettings()
        }
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Methods
    
    private func initAvatar() {
        avatarImage.image = Manager.shared.getAvatar(fileName: Manager.shared.appSettings.avatarFileName)
        //avatarImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarImageTapped)))
    }
    
    private func configureUI() {
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
        avatarImage.addSubview(avatarMenuButton)

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
        
        speedSegmentedControl.selectedSegmentIndex = Manager.shared.appSettings.gameSpeed.rawValue
        speedSegmentedControl.addAction(UIAction(handler: { _ in
            Manager.shared.appSettings.gameSpeed = GameSpeed(rawValue: self.speedSegmentedControl.selectedSegmentIndex) ??  Manager.shared.appSettings.gameSpeed
        }), for: .valueChanged)
        gameSpeedView.addSubview(speedSegmentedControl)
        
        let controlTypeView = UIView()
        containerView.addSubview(controlTypeView)
        
        let controlTypeLabel = UILabel()
        controlTypeLabel.text = Constants.controlTypeText
        controlTypeView.addSubview(controlTypeLabel)
        
        controlTypeSegmentedControl.selectedSegmentIndex = Manager.shared.appSettings.controlType.rawValue
        controlTypeSegmentedControl.addAction(UIAction(handler: { _ in
            Manager.shared.appSettings.controlType = ControlType(rawValue: self.controlTypeSegmentedControl.selectedSegmentIndex) ??  Manager.shared.appSettings.controlType
        }), for: .valueChanged)
        controlTypeView.addSubview(controlTypeSegmentedControl)
        
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
        
        avatarMenuButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        }
        
        gameSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
        }
        
        speedSegmentedControl.snp.makeConstraints { make in
            make.left.right.equalTo(gameSpeedLabel)
            make.top.equalTo(gameSpeedLabel.snp.bottom).offset(GlobalConstants.verticalSpacing)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
        
        controlTypeView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(gameSpeedView.snp.bottom)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
        
        controlTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
        }
        
        controlTypeSegmentedControl.snp.makeConstraints { make in
            make.left.right.equalTo(controlTypeLabel)
            make.top.equalTo(controlTypeLabel.snp.bottom).offset(GlobalConstants.verticalSpacing)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatarImage.image = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImage.image = image
        }
        
        if let image = avatarImage.image {
            Manager.shared.appSettings.avatarFileName = StorageManager.shared.saveImage(image: image) ?? .empty
        }
        
        picker.dismiss(animated: true)
    }
}
