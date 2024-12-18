//
//  UserInfoTableCell.swift
//  Racing2D
//
//  Created by Даниил on 2.12.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let smallFontSize: CGFloat = 12
    static let bigFontSize: CGFloat = 18
    static let avatarSize: CGFloat = 48
    
    static let usernameText = "Username: "
    static let scoreText = "Score: "
}

class RecordTableCell: UITableViewCell {
    // MARK: - Properties
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.avatarSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
}

extension RecordTableCell {
    // MARK: - Methods
    
    private func configureUI() {
        selectionStyle = .none

        contentView.addSubview(usernameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(avatarImage)
        
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.avatarSize)
            make.right.equalToSuperview().inset(GlobalConstants.horizontalSpacing)
            make.centerY.equalToSuperview()
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.left.equalToSuperview().offset(GlobalConstants.horizontalSpacing)
            make.right.equalTo(avatarImage.snp.left).offset(-GlobalConstants.horizontalSpacing)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(GlobalConstants.verticalSpacing)
            make.left.right.equalTo(usernameLabel)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
    }
    
    func initData(data: RecordModel) {
        configureUI()
        
        avatarImage.image = Manager.shared.getAvatar(fileName: data.avatar)
        
        let firstAttr = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.smallFontSize),
        ]
        
        let usernameAttrSrting = NSMutableAttributedString(string: Constants.usernameText, attributes: firstAttr)
        let scoreAttrSrting = NSMutableAttributedString(string: Constants.scoreText, attributes: firstAttr)
        
        let secondAttr = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.bigFontSize, weight: .semibold),
        ]
        
        usernameAttrSrting.append(NSAttributedString(string: data.username, attributes: secondAttr))
        scoreAttrSrting.append(NSAttributedString(string: data.score.description, attributes: secondAttr))
        
        usernameLabel.attributedText = usernameAttrSrting
        scoreLabel.attributedText = scoreAttrSrting
    }
}
