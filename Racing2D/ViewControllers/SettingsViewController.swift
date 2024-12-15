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
        textField.placeholder = Constants.usernamePlaceholder
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [GlobalConstants.slowGameSpeedName, GlobalConstants.mediumGameSpeedName, GlobalConstants.fastGameSpeedName])
        return segmentedControl
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        StorageManager.shared.saveAppSettings()
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
        containerView.backgroundColor = .systemBackground
        containerView.roundCorners()
        view.addSubview(containerView)
        
        let userInfoView = UIView()
        containerView.addSubview(userInfoView)
        
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
        
        let carsView = UIView()
        carView.addSubview(carsView)
        
        let firstCarImage = UIImageView()
        firstCarImage.image = UIImage(named: GlobalConstants.firstCarImage)
        carsView.addSubview(firstCarImage)
        
        let secondCarImage = UIImageView()
        secondCarImage.image = UIImage(named: GlobalConstants.secondCarImage)
        carsView.addSubview(secondCarImage)
        
        let thirdCarImage = UIImageView()
        thirdCarImage.image = UIImage(named: GlobalConstants.thirdCarImage)
        carsView.addSubview(thirdCarImage)
        
        let barrierView = UIView()
        containerView.addSubview(barrierView)
        
        let barrierImageLabel = UILabel()
        barrierImageLabel.text = Constants.barrierImageText
        barrierView.addSubview(barrierImageLabel)
        
        let barriersView = UIView()
        barrierView.addSubview(barriersView)
        
        let firstBarrierImage = UIImageView()
        firstBarrierImage.image = UIImage(named: GlobalConstants.firstBarrierImage)
        barriersView.addSubview(firstBarrierImage)
        
        let secondBarrierImage = UIImageView()
        secondBarrierImage.image = UIImage(named: GlobalConstants.secondBarrierImage)
        barriersView.addSubview(secondBarrierImage)
        
        let thirdBarrierImage = UIImageView()
        thirdBarrierImage.image = UIImage(named: GlobalConstants.thirdBarrierImage)
        barriersView.addSubview(thirdBarrierImage)
        
        let randomBarrierImage = UIImageView()
        randomBarrierImage.image = UIImage(named: GlobalConstants.randomBarrierImage)
        barriersView.addSubview(randomBarrierImage)
        
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
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.right.equalToSuperview().inset(Constants.horizontalSpacing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.topSpacing)
        }
        
        userInfoView.snp.makeConstraints { make in
            make.top.left.right.equalTo(containerView)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalSpacing)
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.right.equalToSuperview().inset(Constants.horizontalSpacing)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.left.right.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp.bottom).offset(Constants.verticalSpacing)
            make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
        }
        
        carView.snp.makeConstraints { make in
            make.left.right.equalTo(userInfoView)
            make.top.equalTo(userInfoView.snp.bottom)
        }
        
        carImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalSpacing)
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.right.equalToSuperview().inset(Constants.horizontalSpacing)
        }
        
        carsView.snp.makeConstraints { make in
            make.top.equalTo(carImageLabel.snp.bottom).offset(Constants.verticalSpacing)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
        }
        
        firstCarImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.width.height.equalTo(Constants.imageSize)
        }
        
        secondCarImage.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(firstCarImage)
            make.left.equalTo(firstCarImage.snp.right).offset(Constants.horizontalSpacing)
        }
        
        thirdCarImage.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(secondCarImage)
            make.left.equalTo(secondCarImage.snp.right).offset(Constants.horizontalSpacing)
        }
        
        barrierView.snp.makeConstraints { make in
            make.left.right.equalTo(carView)
            make.top.equalTo(carView.snp.bottom)
        }
        
        barrierImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalSpacing)
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.right.equalToSuperview().inset(Constants.horizontalSpacing)
        }
        
        barriersView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(barrierImageLabel.snp.bottom).offset(Constants.verticalSpacing)
            make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
        }
        
        firstBarrierImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.width.height.equalTo(Constants.imageSize / 1.5)
        }
        
        secondBarrierImage.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(firstBarrierImage)
            make.left.equalTo(firstBarrierImage.snp.right).offset(Constants.horizontalSpacing)
        }
        
        thirdBarrierImage.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(secondBarrierImage)
            make.left.equalTo(secondBarrierImage.snp.right).offset(Constants.horizontalSpacing)
        }
        
        randomBarrierImage.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(thirdBarrierImage)
            make.left.equalTo(thirdBarrierImage.snp.right).offset(Constants.horizontalSpacing)
        }
        
        gameSpeedView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(barrierView.snp.bottom)
            make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
        }
        
        gameSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalSpacing)
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.right.equalToSuperview().inset(Constants.horizontalSpacing)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.left.right.equalTo(gameSpeedLabel)
            make.top.equalTo(gameSpeedLabel.snp.bottom).offset(Constants.verticalSpacing)
            make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
        }
    }
    
    @objc func didTap() {
        view.endEditing(true) // закрыть клавиатуру
    }
}
