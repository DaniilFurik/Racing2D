//
//  UserInfoTableCell.swift
//  Racing2D
//
//  Created by Даниил on 2.12.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let horizontalSpacing: CGFloat = 16
    static let verticalSpacing: CGFloat = 8
    
    static let smallFontSize: CGFloat = 12
    static let bigFontSize: CGFloat = 18
    
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
    
    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordTableCell {
    // MARK: - Methods
    
    private func configureUI() {
        selectionStyle = .none

        contentView.addSubview(usernameLabel)
        contentView.addSubview(scoreLabel)
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalSpacing)
            make.left.equalToSuperview().offset(Constants.horizontalSpacing)
            make.right.equalToSuperview().inset(Constants.horizontalSpacing)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(Constants.verticalSpacing)
            make.left.right.equalTo(usernameLabel)
            make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
        }
    }
    
    func initData(data: RecordModel) {
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
