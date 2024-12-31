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
    static let middleFontSize: CGFloat = 16
    static let avatarSize: CGFloat = 64
    
    static let usernameText = "Username: "
    static let scoreText = "Score: "
    static let dateText = "Date: "
    
    static let dateFormat = "dd MMM yyyy HH'h' mm'm' ss's'"
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private let avatarImage = AvatarImageView(size: Constants.avatarSize)
}

extension RecordTableCell {
    // MARK: - Methods
    
    private func configureUI() {
        selectionStyle = .none

        contentView.addSubview(usernameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(avatarImage)
        contentView.addSubview(dateLabel)
        
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
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(GlobalConstants.verticalSpacing)
            make.left.right.equalTo(scoreLabel)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
    }
    
    func initData(data: UserRecord) {
        configureUI()
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        
        avatarImage.image = Manager.shared.getAvatar(fileName: data.avatarFileName)
        
        let firstAttr = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.smallFontSize),
        ]
        
        let secondAttr = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.bigFontSize, weight: .semibold),
        ]
        
        let thirdAttr = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.middleFontSize, weight: .semibold),
        ]
        
        let usernameAttrSrting = NSMutableAttributedString(string: Constants.usernameText, attributes: firstAttr)
        let scoreAttrSrting = NSMutableAttributedString(string: Constants.scoreText, attributes: firstAttr)
        let dateAttrSrting = NSMutableAttributedString(string: Constants.dateText, attributes: firstAttr)
        
        usernameAttrSrting.append(NSAttributedString(string: data.username, attributes: secondAttr))
        scoreAttrSrting.append(NSAttributedString(string: data.score.description, attributes: secondAttr))
        dateAttrSrting.append(NSAttributedString(string: formatter.string(from: Date(timeIntervalSince1970: data.date)), attributes: thirdAttr))
        
        usernameLabel.attributedText = usernameAttrSrting
        scoreLabel.attributedText = scoreAttrSrting
        dateLabel.attributedText = dateAttrSrting
    }
}
